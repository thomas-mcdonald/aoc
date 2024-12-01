input = File.read("./day1.input")

data = input.split("\n").map { |line| line.split(/\s+/).map(&:to_i) }
counts = {}
left = data.map { |xs| xs[0] }
right = data.map { |xs| xs[1] }

# collect valid set of keys
left.each do |l|
  counts[l] = 0
end

right.each do |r|
  counts[r] += 1 if counts.key?(r)
end

puts counts.reduce(0) { |acc, (k, v)| acc + (k * v) }
