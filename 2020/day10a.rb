input = File.read("./day10.input").split("\n").map(&:to_i).sort

input << 0
input << input.max + 3

diffs = Hash.new { |h, k| h[k] = 0 }

sorted = input.sort
sorted.each_with_index do |val, idx|
  next if sorted[idx + 1].nil?
  diffs[sorted[idx + 1] - val] += 1
end

puts diffs
