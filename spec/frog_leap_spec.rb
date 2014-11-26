require 'spec_helper'

describe FrogLeap do
  before :all do
    @river_width = 5
    @min_falling_leaves = [1]
    @short_falling_leaves = [1, 2, 3]
    @regular_falling_leaves = [1, 3, 1, 4, 2, 3, 5, 4]
    @max_falling_leaves = Array.new(FrogLeap::MAX_RIVER_WIDTH, 1..FrogLeap::MAX_RIVER_WIDTH)
    @kermit = FrogLeap.new(@river_width, @regular_falling_leaves)
  end
  
  it "is valid with an integer value for river_width between MIN_RIVER_WIDTH (value #{FrogLeap::MIN_RIVER_WIDTH}) and MAX_RIVER_WIDTH (value #{FrogLeap::MAX_RIVER_WIDTH})" do
    expect{FrogLeap.new(FrogLeap::MIN_RIVER_WIDTH, @min_falling_leaves)}.not_to raise_error
    expect{FrogLeap.new(@river_width, @min_falling_leaves)}.not_to raise_error
    expect{FrogLeap.new(FrogLeap::MAX_RIVER_WIDTH, @min_falling_leaves)}.not_to raise_error
  end
  
  it "is valid with individual integer value for falling_leaves between MIN_RIVER_WIDTH (value #{FrogLeap::MIN_RIVER_WIDTH}) and the given river_width" do
    expect{FrogLeap.new(@river_width, @min_falling_leaves)}.not_to raise_error
    expect{FrogLeap.new(@river_width, @short_falling_leaves)}.not_to raise_error
    expect{FrogLeap.new(@river_width, @regular_falling_leaves)}.not_to raise_error
  end
  
  it "is invalid without a river_width value" do
    expect{FrogLeap.new(nil, @min_falling_leaves)}.to raise_error
  end
  
  it "is invalid without an array of falling_leaves value" do
    expect{FrogLeap.new(@river_width, nil)}.to raise_error
  end
  
  it "is invalid without an integer river_width value between MIN_RIVER_WIDTH (value #{FrogLeap::MIN_RIVER_WIDTH}) and MAX_RIVER_WIDTH (value #{FrogLeap::MAX_RIVER_WIDTH})" do
    expect{FrogLeap.new("test", @min_falling_leaves)}.to raise_error
    expect{FrogLeap.new(-1, @min_falling_leaves)}.to raise_error
    expect{FrogLeap.new([5], @min_falling_leaves)}.to raise_error
    expect{FrogLeap.new(5.5, @min_falling_leaves)}.to raise_error
  end
  
  it "is invalid without an array of falling_leaves with individual integer values between MIN_RIVER_WIDTH (value #{FrogLeap::MIN_RIVER_WIDTH}) and the given river_width" do
    expect{FrogLeap.new(@river_width, 1)}.to raise_error
    expect{FrogLeap.new(@river_width, ["test"])}.to raise_error
    expect{FrogLeap.new(@river_width, [1, 3, 1, 4, 2, 3, 0, 4])}.to raise_error
    expect{FrogLeap.new(@river_width, [1, 3, 1, 4, 2, 3, 6, 4])}.to raise_error
    expect{FrogLeap.new(@river_width, [1, 3, 1, 4, 2, 3, "blah", 4])}.to raise_error
    expect{FrogLeap.new(@river_width, @max_falling_leaves)}.to raise_error
  end
end