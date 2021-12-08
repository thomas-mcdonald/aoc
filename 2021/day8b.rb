require "set"

input = File.read("./day8.input").split("\n").map do |line|
  line.split(" | ").map { |block| block.split(" ").map { |str| str.split("") } }
end

res = input.map do |configuration|
  values = configuration[0] + configuration[1]
  display = {}
  display[1] = values.find { |char| char.length == 2 }
  display[7] = values.find { |char| char.length == 3 }
  display[4] = values.find { |char| char.length == 4 }
  display[8] = values.find { |char| char.length == 7 }

  display[3] = values.find { |char| char.length == 5 && (display[7] - char).empty? }
  display[5] = values.find { |char| char.length == 5 && ((display[4] - display[1]) - char).empty? }
  display[2] = values.find { |char| char.length == 5 && char != display[3] && char != display[5] }

  six_length = values.select { |char| char.length == 6 }
  display[0] = six_length.find { |char| ((display[4] - display[1]) - char).length > 0 }
  display[9] = six_length.find { |char| (display[4] - char).length == 0 }
  display[6] = six_length.find { |char| char != display[0] && char != display[9] }

  display = display.map do |k, v|
    [k, v.sort]
  end.to_h

  output_values = configuration[1]
  output_values.map do |i|
    display.key(i.sort)
  end.join("").to_i
end

puts res.sum
