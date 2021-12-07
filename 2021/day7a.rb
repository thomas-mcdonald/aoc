input = File.read("./day7.input").split(",").map(&:to_i)

result = (input.min..input.max).map do |i|
  input.map { |x| (x - i).abs }.sum
end

puts result.min
