input = File.read("./day10.input").split("\n").map(&:to_i).sort

input << 0
input << input.max + 3

counts = Hash.new { |h, k| h[k] = 0 }
counts[0] = 1

sorted = input.sort
sorted.each_with_index do |val, idx|
  next if sorted[idx + 1].nil?

  targets = [sorted[idx + 1], sorted[idx + 2], sorted[idx + 3]].intersection (val+1..val+3).to_a
  targets.each { |target| counts[target] += counts[val] }
end

puts counts
