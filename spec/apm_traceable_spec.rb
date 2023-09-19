# frozen_string_literal: true

RSpec.describe ApmTraceable do
  it 'has a version number' do
    expect(ApmTraceable::VERSION).not_to be_nil
  end
end
