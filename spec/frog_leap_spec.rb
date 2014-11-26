require 'spec_helper'

describe FrogLeap do
  before :all do
    @river_width = 5
    
    @min_falling_leaves = [1]
    @short_falling_leaves = [1, 2, 3]
    @regular_falling_leaves = [1, 3, 1, 4, 2, 3, 5, 4]
    @max_falling_leaves = Array.new(FrogLeap::MAX_RIVER_WIDTH) {|i| i+1 }
    
    @min_leap =     FrogLeap.new(@river_width, @min_falling_leaves)               # Fails to reach
    @short_leap =   FrogLeap.new(@river_width, @short_falling_leaves)             # Fails to reach
    @regular_leap = FrogLeap.new(@river_width, @regular_falling_leaves)           # Does reach
    @max_leap =     FrogLeap.new(FrogLeap::MAX_RIVER_WIDTH, @max_falling_leaves)  # Does reach
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
  
  describe "calculate leap time" do
    it "returns ERROR_RETURN_CODE (value #{FrogLeap::ERROR_RETURN_CODE}) when falling_leaves values do not appear at least once for every position in the river_width" do
      expect(@min_leap.plain_time_result).to eq(FrogLeap::ERROR_RETURN_CODE)
      expect(@short_leap.plain_time_result).to eq(FrogLeap::ERROR_RETURN_CODE)
    end
    
    it "returns leap time value when falling_leaves values appear at least once for every position in the river_width" do
      expect(@regular_leap.plain_time_result).to eq(6) # Minute 6 is when the frog should be able to jump
      expect(@max_leap.plain_time_result).to eq(99999) # Minute 99,999 is when the frog should be able to jump
    end
    
    it "returns verbose error message when falling_leaves values do not appear at least once for every position in the river_width" do
      expect(@min_leap.show_verbose_time_result).to eq("\n\nThe frog is never able to jump to the other side of the river")
      expect(@short_leap.show_verbose_time_result).to eq("\n\nThe frog is never able to jump to the other side of the river")
    end
    
    it "returns verbose leap time when falling_leaves values appear at least once for every position in the river_width" do
      expect(@regular_leap.show_verbose_time_result).to eq("\n\nThe earliest time when the frog can jump to the other side of the river is at minute 6") # Minute 6 is when the frog should be able to jump
      expect(@max_leap.show_verbose_time_result).to eq("\n\nThe earliest time when the frog can jump to the other side of the river is at minute 99999") # Minute 99,999 is when the frog should be able to jump
    end
  end
end