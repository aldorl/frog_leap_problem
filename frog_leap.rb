MIN_RIVER_WIDTH = 1
MAX_RIVER_WIDTH = 100000

def read_input_arguments
  # First command-line argument, expected to be  an integer value between MIN_RIVER_WIDTH and MAX_RIVER_WIDTH
  river_width = ARGV.shift.to_i
  raise ArgumentError, "Argument is not an integer value between #{MIN_RIVER_WIDTH} and #{MAX_RIVER_WIDTH}" unless river_width.is_a?(Integer) && river_width >= MIN_RIVER_WIDTH && river_width <= MAX_RIVER_WIDTH
  puts "The width of the river is #{river_width}"
  
  # Second command-line argument, expected to be the name of a file which has the positions of falling leaves
  falling_leaves = ARGF.readlines.map(&:chomp)
  
  falling_leaves.each_with_index do |leaf_position, time|
    falling_leaves[time] = leaf_position.to_i
    raise ArgumentError, "Argument is not an integer value between 1 and #{river_width}" unless falling_leaves[time].is_a?(Integer) && falling_leaves[time] >= 1 && falling_leaves[time] <= river_width
    puts "At minute #{time}, a leaf falls in position #{falling_leaves[time]}"
  end
  
  return river_width, falling_leaves
end

def calculate_earliest_leap_time(river_width, falling_leaves)
  puts "\n\nThis many leaves fall in total: #{falling_leaves.length}\n\n"
  
  # The unique_leaves_positions array size should be one more than the river width, given that it's a zero-indexed array
  unique_leaves_positions = Array.new(river_width+1, false)
  unique_leaves_positions_counter = 0
  
  falling_leaves.each_with_index do |leaf_position, time|
    if unique_leaves_positions[leaf_position] == false
      unique_leaves_positions[leaf_position] = true
      unique_leaves_positions_counter += 1
      puts "The first time a leaf falls in position #{leaf_position} is at minute #{time}"
      puts "The leaves counter is now at #{unique_leaves_positions_counter}"
    end
    return time if unique_leaves_positions_counter == river_width
  end
  
  return -1
end

def show_time_result(leap_time)
  puts leap_time == -1 ? "\n\nThe frog is never able to jump to the other side of the river" : "\n\nThe earliest time when the frog can jump to the other side of the river is at minute #{leap_time}"
end


############################## MAIN FUNCTIONS STARTS HERE############################## 

river_width, falling_leaves = read_input_arguments
show_time_result( calculate_earliest_leap_time( river_width, falling_leaves ) )