input = File.read("./day9.input").split("\n").map { |line| line.split("").map(&:to_i) }

points = []

input.each_with_index do |line, x|
  line.each_with_index do |num, y|
    low_point = true
    low_point &= num < input[x - 1][y] if x > 0
    low_point &= num < input[x + 1][y] if x < (input.length - 1)
    low_point &= num < input[x][y - 1] if y > 0
    low_point &= num < input[x][y + 1] if y < (input[0].length - 1)
    points << [num, [x, y]] if low_point
  end
end

res = points.map { |x| x[0] + 1 }.sum

puts res
