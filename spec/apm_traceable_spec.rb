# frozen_string_literal: true

RSpec.describe ApmTraceable do
  it 'has a version number' do
    expect(ApmTraceable::VERSION).not_to be_nil
  end

  describe '.configure' do
    it 'Adapter設定を保持できる' do
      described_class.configure do |config|
        config.adapter = 'stdout'
      end
      expect(described_class.configuration.adapter).to be_a ApmTraceable::Adapters::StdoutAdapter
    end
  end
end
