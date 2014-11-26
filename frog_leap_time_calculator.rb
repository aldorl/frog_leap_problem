require_relative 'frog_leap'

def read_input_arguments
  # First command-line argument, expected to be an integer value between MIN_RIVER_WIDTH and MAX_RIVER_WIDTH
  river_width = ARGV.shift.to_i
  puts "The width of the river is #{river_width}"
  
  # Second command-line argument, expected to be the name of a file which has the positions of falling leaves
  falling_leaves = ARGF.readlines.map(&:chomp)
  
  falling_leaves.each_with_index do |leaf_position, time|
    falling_leaves[time] = leaf_position.to_i
    puts "At minute #{time}, a leaf falls in position #{falling_leaves[time]}"
  end
  
  return river_width, falling_leaves
end

############################## MAIN FUNCTIONS STARTS HERE############################## 

river_width, falling_leaves = read_input_arguments
kermit = FrogLeap.new(river_width, falling_leaves)
kermit.show_time_result