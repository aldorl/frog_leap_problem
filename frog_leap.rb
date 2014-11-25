def read_input_arguments
  @river_width = ARGV.shift
  puts "The width of the river is #{@river_width}"
  @falling_leaves = ARGF.readlines
  puts "Leaves fall in the following order:"
  @falling_leaves.each_with_index do |leaf_position, time|
    puts "At minute #{time}, a leaf falls in position #{leaf_position}"
  end
end

# Read input arguments
read_input_arguments