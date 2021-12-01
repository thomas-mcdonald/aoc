input = File.read("./day11.input").split("\n").map { |str| str.split("") }

# pad input with floor to make index lookups easier
state = input.map { |row| ["."] + row + ["."] }
chars = state[0].length
state = [Array.new(chars) { "." }] + state + [Array.new(chars) { "." }]

# state.each { |row| puts row.inspect }

def find_seat(state, i, j, dx, dy)
  x = i + dx
  y = j + dy
  while x > 0 && x + 1 < state.length && y > 0 && y < state[0].length && state[x][y] == "."
    x = x + dx
    y = y + dy
  end
  state[x][y]
end

loop do
  state.each { |row| puts row.join("") }
  puts "!!!"

  new_state = []
  state.each_with_index do |x, i|
    new_state[i] ||= []
    x.each_with_index do |y, j|
      case y
      when "."
        new_state[i][j] = "."
      when "L"
        count = [[-1, 0], [-1, +1], [0, +1], [+1, +1], [+1, 0], [1, -1], [0, -1], [-1, -1]].map { |dx, dy| find_seat(state, i, j, dx, dy) }.select { |char| char == "#" }.count
        if count.zero?
          new_state[i][j] = "#"
        else
          new_state[i][j] = "L"
        end
      when "#"
        count = [[-1, 0], [-1, +1], [0, +1], [+1, +1], [+1, 0], [1, -1], [0, -1], [-1, -1]].map { |dx, dy| find_seat(state, i, j, dx, dy) }.select { |char| char == "#" }.count
        if count > 4
          new_state[i][j] = "L"
        else
          new_state[i][j] = "#"
        end
      end
    end
  end

  if state == new_state
    break
  end

  state = new_state
end

puts state.map { |row| row.select { |char| char == "#" }.count }.sum
