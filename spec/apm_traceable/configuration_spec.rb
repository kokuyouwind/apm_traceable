# frozen_string_literal: true

RSpec.describe ApmTraceable::Configuration do
  let(:config) { described_class.new }

  describe '#service_name' do
    it '未設定で参照すると例外を投げる' do
      expect { config.service_name }.to raise_error(ApmTraceable::Configuration::InsufficientConfigurationError)
    end
  end

  describe '#service_name=' do
    it 'service_nameを設定できる' do
      config.service_name = 'service_name'
      expect(config.service_name).to eq 'service_name'
    end
  end

  describe '#adapter' do
    it '未設定で参照すると例外を投げる' do
      expect { config.adapter }.to raise_error(ApmTraceable::Configuration::InsufficientConfigurationError)
    end
  end

  describe '#adapter=' do
    it 'adapterを設定できる' do
      config.adapter = ApmTraceable::Adapters::BaseAdapter.new
      expect(config.adapter).to be_a ApmTraceable::Adapters::BaseAdapter
    end
  end
end
