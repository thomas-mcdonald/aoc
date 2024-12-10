input = File.read("day9.input").strip.split("").map(&:to_i)

file_mode = "file_size"
tape = []
id = 0
output_length = 0

input.each_with_index do |size, idx|
  next unless idx % 2 == 0
  tape = tape.concat([id.to_s] * size)
  output_length += size
  id += 1
end

start = 0
last = tape.length - 1

total_length = input.sum

output = []
input.each_with_index do |size, idx|
  if idx % 2 == 0
    output = output.concat(tape.slice(start, size))
    start += size
  else
    output = output.concat(tape.slice(last - size + 1, size).reverse)
    last -= size
  end
end

output = output[0..(output_length - 1)]
checksum = output.each_with_index.map do |val, idx|
  val.to_i * idx
end
puts checksum.sum
