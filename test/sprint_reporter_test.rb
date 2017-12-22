require 'test_helper'

describe 'sprint reporter' do
  it 'works' do
    expect(2).must_equal 2
  end

  it 'has version' do
    expect(SprintReporter::VERSION).must_be_instance_of String
  end
end
