input = File.read("./day7.input").split(",").map(&:to_i)

result = (input.min..input.max).map do |i|
  input.map do |x|
    distance = (x - i).abs
    cost = (distance * (distance + 1)) / 2
  end.sum
end

puts result.min
