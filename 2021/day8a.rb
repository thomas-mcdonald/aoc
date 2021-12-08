input = File.read("./day8.input").split("\n").map do |line|
  line.split(" | ").map { |block| block.split(" ").map { |str| str.split("") } }
end

puts (input.map do |line|
  output_values = line[1]
  output_values.count { |char| [2, 3, 4, 7].include? char.length }
end.sum)
