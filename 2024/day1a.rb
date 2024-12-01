input = File.read("./day1.input")

data = input.split("\n").map { |line| line.split(/\s+/).map(&:to_i) }
left = data.map { |xs| xs[0] }.sort
right = data.map { |xs| xs[1] }.sort

puts left.zip(right).map { |xs| (xs[0] - xs[1]).abs }.sum
