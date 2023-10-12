# frozen_string_literal: true

RSpec.describe ApmTraceable do
  it 'has a version number' do
    expect(ApmTraceable::VERSION).not_to be_nil
  end

  describe '.configure' do
    it '設定値を保持できる' do
      described_class.configure do |config|
        config.service_name = 'service_name'
        config.adapter = ApmTraceable::Adapters::BaseAdapter.new
      end
      expect(described_class.configuration.service_name).to eq 'service_name'
      expect(described_class.configuration.adapter).to be_a ApmTraceable::Adapters::BaseAdapter
    end
  end
end
