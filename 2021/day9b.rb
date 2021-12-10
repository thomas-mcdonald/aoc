require "set"

input = File.read("./day9.input").split("\n").map { |line| line.split("").map(&:to_i) }

points = []

input.each_with_index do |line, x|
  line.each_with_index do |num, y|
    low_point = true
    low_point &= num < input[x - 1][y] if x > 0
    low_point &= num < input[x + 1][y] if x < (input.length - 1)
    low_point &= num < input[x][y - 1] if y > 0
    low_point &= num < input[x][y + 1] if y < (input[0].length - 1)
    points << [x, y] if low_point
  end
end

basins = []

points.each do |starting_point|
  basin = Set.new([starting_point])
  queue = [starting_point]
  while !queue.empty?
    point = queue.shift
    x = point[0]
    y = point[1]

    if x > 0 && input[x][y] < input[x - 1][y] && input[x - 1][y] != 9
      basin << [x - 1, y]
      queue << [x - 1, y]
    end
    if x < (input.length - 1) && input[x][y] < input[x + 1][y] && input[x + 1][y] != 9
      basin << [x + 1, y]
      queue << [x + 1, y]
    end
    if y > 0 && input[x][y] < input[x][y - 1] && input[x][y - 1] != 9
      basin << [x, y - 1]
      queue << [x, y - 1]
    end
    if y < (input[0].length - 1) && input[x][y] < input[x][y + 1] && input[x][y + 1] != 9
      basin << [x, y + 1]
      queue << [x, y + 1]
    end
  end
  basins << basin
end

biggest = basins.map { |b| b.size }.sort.reverse[0..2]
puts biggest[0] * biggest[1] * biggest[2]
