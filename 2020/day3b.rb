input = File.read("./day3.input").split("\n").map { |row| row.split("") }

width = input[0].length

steps = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]

counts = steps.map do |x_d, y_d|
  x, y = 0, 0
  count = 0
  while y < input.size
    count += 1 if input[y][x % width] == "#"
    x += x_d
    y += y_d
  end
  count
end

puts counts.reduce(&:*)
