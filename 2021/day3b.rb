input = File.read("./day3.input").split("\n").map { |str| str.split("").map(&:to_i) }

def most_common_bit(table, idx)
  row = table.transpose[idx]
  counts = [0, 1].map { |i| row.count(i) }
  if counts[0] > counts[1]
    0
  else
    1
  end
end

def least_common_bit(table, idx)
  row = table.transpose[idx]
  counts = [0, 1].map { |i| row.count(i) }
  if counts[0] <= counts[1]
    0
  else
    1
  end
end

oxgen = input.dup
idx = 0
while oxgen.length > 1
  bit = most_common_bit(oxgen, idx)
  oxgen = oxgen.select { |num| num[idx] == bit }
  idx += 1
end
oxgen_value = oxgen.shift.join("").to_i(2)

scrubber = input.dup
idx = 0
while scrubber.length > 1
  bit = least_common_bit(scrubber, idx)
  scrubber = scrubber.select { |num| num[idx] == bit }
  idx += 1
end
scrubber_value = scrubber.shift.join("").to_i(2)

puts oxgen_value * scrubber_value
