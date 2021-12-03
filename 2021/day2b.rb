input = File.read("./day2.input").split("\n").map { |str| str.split(" ") }

depth = 0
horiz = 0
aim = 0

input.each do |instruction|
  command = instruction[0].to_sym
  value = instruction[1].to_i

  case command
  when :forward
    horiz += value
    depth += (value * aim)
  when :down
    aim += value
  when :up
    aim -= value
  end
end

puts horiz * depth
