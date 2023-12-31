# frozen_string_literal: true

class TracerTestClass
  include ApmTraceable::Tracer

  trace_methods :test_trace_method
  def test_trace_method
    'test'
  end
end

RSpec.describe ApmTraceable::Tracer do
  let(:test_object) { TracerTestClass.new }

  before do
    ApmTraceable.configure do |config|
      config.adapter = 'stdout'
    end
  end

  describe '#trace_methods' do
    it 'trace_methodsで指定したメソッドがtrace_spanを呼び出す' do
      allow(test_object).to receive(:trace_span) { |_, &block| block.call }
      expect(test_object.test_trace_method).to eq 'test'
      expect(test_object).to have_received(:trace_span).with('test_trace_method')
    end
  end

  describe '#trace_span' do
    subject { test_object.trace_span('test_name', option1: :value1) { 'test' } }

    it 'StdoutAdapter#traceを呼び出す' do
      allow(ApmTraceable.configuration.adapter).to receive(:trace).and_call_original
      expect { subject }.to output(/TracerTestClass#test_name 0.[0-9]{6}s/).to_stdout
      expect(subject).to eq('test')
      expect(ApmTraceable.configuration.adapter).to have_received(:trace).with(
        'test_name',
        context_class: TracerTestClass,
        option1: :value1
      )
    end
  end
end
