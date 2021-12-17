require "strscan"

input = File.read("./day14.input").split("\n\n")

seed = input[0]
instructions = input[1].split("\n").map { |ins| ins.split(" -> ") }.to_h

pc = 0
value = seed
counts = Hash.new { |h, k| h[k] = 0 }

value.split("").each_cons(2).each { |tup| counts[tup.join("")] += 1 }

puts counts

while pc < 40
  new_counts = Hash.new { |h, k| h[k] = 0 }
  counts.each do |k, v|
    next if v.zero?

    new_char = instructions[k]
    left = [k.split("")[0], new_char]
    right = [new_char, k.split("")[1]]
    new_counts[left.join("")] += v
    new_counts[right.join("")] += v
  end
  counts = new_counts
  pc += 1
end

char_counts = Hash.new { |h, k| h[k] = 0 }
counts.each do |k, v|
  char_counts[k.split("")[0]] += v
end
char_counts[value.split("").last] += 1


max_ch = char_counts.max_by { |_k, v| v }[1]
min_ch = char_counts.min_by { |_k, v| v }[1]

puts max_ch - min_ch
