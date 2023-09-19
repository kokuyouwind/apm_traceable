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

  describe '#trace_methods' do
    it 'trace_methodsで指定したメソッドがtrace_spanを呼び出す' do
      allow(test_object).to receive(:trace_span) { |_, &block| block.call }
      expect(test_object.test_trace_method).to eq 'test'
      expect(test_object).to have_received(:trace_span).with('test_trace_method')
    end
  end

  describe '#trace_span' do
    it 'Datadog::Tracing#traceを呼び出す' do
      allow(Datadog::Tracing).to receive(:trace) { |_, &block| block.call }
      expect(test_object.trace_span(:test_resource, option1: :value1) { 'test' }).to eq 'test'
      expect(Datadog::Tracing).to have_received(:trace).with(
        'tracer_test_class',
        option1: :value1,
        service: 'service_name',
        resource: :test_resource
      )
    end
  end
end
