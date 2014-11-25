def read_input_arguments
  @river_width = ARGV.shift.to_i
  puts "The width of the river is #{@river_width}"
  @falling_leaves = ARGF.readlines.map(&:chomp)
  puts "Leaves fall in the following order:"
  @falling_leaves.each_with_index do |leaf_position, time|
    @falling_leaves[time] = leaf_position.to_i
    puts "At minute #{time}, a leaf falls in position #{leaf_position}"
  end
end

def generate_leaves_positions_variables
  # The @unique_leaves_positions array size should be one more than the river width, given that it's a zero-indexed array
  @unique_leaves_positions = Array.new(@river_width+1, false)
  @unique_leaves_positions_counter = 0
end

def calculate_earliest_frog_leap_time
  puts "\n\nThis many leaves fall in total: #{@falling_leaves.length}"
  @falling_leaves.each_with_index do |leaf_position, time|
    if @unique_leaves_positions[leaf_position] == false
      puts "First time for a leaf falling in position #{leaf_position}"
      puts "Leaf fell at time #{time}"
      @unique_leaves_positions[leaf_position] = true
      @unique_leaves_positions_counter += 1
      puts "The leaves counter is now at #{@unique_leaves_positions_counter}"
    end
    return time if @unique_leaves_positions_counter == @river_width
  end
  return -1
end

def show_time_result(leap_time)
  puts leap_time == -1 ? "\n\nThe frog is never able to jump to the other side of the river" : "\n\nThe earliest time when the frog can jump to the other side of the river is at minute #{leap_time}"
end

read_input_arguments
generate_leaves_positions_variables
show_time_result(calculate_earliest_frog_leap_time)