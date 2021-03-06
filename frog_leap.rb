class FrogLeap
  MIN_RIVER_WIDTH = 1
  MAX_RIVER_WIDTH = 100000
  ERROR_RETURN_CODE = -1
  
  attr_accessor :river_width, :falling_leaves
  
  def initialize(river_width, falling_leaves)
    # Data types validation
    raise ArgumentError, "Argument is not an integer value between #{MIN_RIVER_WIDTH} and #{MAX_RIVER_WIDTH}" unless river_width.is_a?(Integer) && river_width >= MIN_RIVER_WIDTH && river_width <= MAX_RIVER_WIDTH
    falling_leaves.each_with_index do |leaf_position, time|
      raise ArgumentError, "Argument is not an integer value between #{MIN_RIVER_WIDTH} and #{river_width}" unless falling_leaves[time].is_a?(Integer) && falling_leaves[time] >= MIN_RIVER_WIDTH && falling_leaves[time] <= river_width
    end
    
    #Instance variables
    @river_width = river_width
    @falling_leaves = falling_leaves
  end
  
  def plain_time_result
    return calculate_earliest_leap_time
  end
  
  def show_verbose_time_result
    leap_time = plain_time_result
    return leap_time == -1 ? "\n\nThe frog is never able to jump to the other side of the river" : "\n\nThe earliest time when the frog can jump to the other side of the river is at minute #{leap_time}"
  end
  
  private
    def calculate_earliest_leap_time
      #puts "\n\nThis many leaves fall in total: #{falling_leaves.length}\n\n"

      # The unique_leaves_positions array size should be one more than the river width, given that it's a zero-indexed array
      unique_leaves_positions = Array.new(river_width+1, false)
      unique_leaves_positions_counter = 0

      falling_leaves.each_with_index do |leaf_position, time|
        if unique_leaves_positions[leaf_position] == false
          unique_leaves_positions[leaf_position] = true
          unique_leaves_positions_counter += 1
          #puts "The first time a leaf falls in position #{leaf_position} is at minute #{time}"
          #puts "The leaves counter is now at #{unique_leaves_positions_counter}"
        end
        return time if unique_leaves_positions_counter == river_width
      end

      return ERROR_RETURN_CODE
    end
end