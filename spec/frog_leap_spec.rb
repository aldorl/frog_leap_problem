require 'spec_helper'

describe FrogLeap do
  before :all do
    @river_width = 5
    @short_falling_leaves = [1]
    @regular_falling_leaves = [1, 3, 1, 4, 2, 3, 5, 4]
    @kermit = FrogLeap.new(@river_width, @regular_falling_leaves)
  end
  
  it "is valid with an integer value for river_width between MIN_RIVER_WIDTH and MAX_RIVER_WIDTH" do
    expect{FrogLeap.new(FrogLeap::MIN_RIVER_WIDTH, @short_falling_leaves)}.not_to raise_error
    expect{FrogLeap.new(@river_width, @regular_falling_leaves)}.not_to raise_error
    expect{FrogLeap.new(FrogLeap::MAX_RIVER_WIDTH, @regular_falling_leaves)}.not_to raise_error
  end
end