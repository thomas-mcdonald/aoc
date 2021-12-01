input = File.read("./day3.input").split("\n").map { |row| row.split("") }

width = input[0].length
x, y = 0, 0
count = 0

while y != input.size
  count += 1 if input[y][x % width] == "#"
  x += 3
  y += 1
end

puts count
