# frozen_string_literal: true

RSpec.describe ApmTraceable::Configuration do
  let(:config) { described_class.new }

  describe '#adapter' do
    it '未設定で参照すると例外を投げる' do
      expect { config.adapter }.to raise_error(ApmTraceable::Configuration::InsufficientConfigurationError)
    end
  end

  describe '#adapter=' do
    it '名前からadapterを設定できる' do
      config.adapter = 'stdout'
      expect(config.adapter).to be_a ApmTraceable::Adapters::StdoutAdapter
    end

    it 'オプション引数を渡せる' do
      allow(ApmTraceable::Adapters::StdoutAdapter).to receive(:new)
      config.adapter = 'stdout', { key: 'val' }
      expect(ApmTraceable::Adapters::StdoutAdapter).to have_received(:new).with(key: 'val')
    end
  end
end
