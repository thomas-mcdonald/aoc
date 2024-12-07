require "set"

input = File.read("day6.input").strip.split("\n").map { |xs| xs.split("") }

initial_x = input.find_index { |xs| xs.include?("^") }
initial_y = input[initial_x].find_index { |x| x == "^" }


visited = Set.new
guard = [initial_x, initial_y]
direction = "up"
steps = 0

loop do
  steps += 1
  visited.add(guard)
  x, y = guard
  case direction
  when "up"
    break if x == 0
    if input[x - 1][y] == "#"
      direction = "right"
      guard = [x, y + 1]
    else
      guard = [x - 1, y]
    end
  when "right"
    break if y == input[x].size - 1
    if input[x][y + 1] == "#"
      direction = "down"
      guard = [x + 1, y]
    else
      guard = [x, y + 1]
    end
  when "down"
    break if x == input.size - 1
    if input[x + 1][y] == "#"
      direction = "left"
      guard = [x, y - 1]
    else
      guard = [x + 1, y]
    end
  when "left"
    break if y == 0
    if input[x][y - 1] == "#"
      direction = "up"
      guard = [x - 1, y]
    else
      guard = [x, y - 1]
    end
  end
end

puts steps
puts visited.size
