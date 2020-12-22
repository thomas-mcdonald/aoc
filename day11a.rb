input = File.read("./day11.input").split("\n").map { |str| str.split("") }

# pad input with floor to make index lookups easier
state = input.map { |row| ["."] + row + ["."] }
chars = state[0].length
state = [Array.new(chars) { "." }] + state + [Array.new(chars) { "." }]

loop do
  new_state = []
  state.each_with_index do |x, i|
    new_state[i] ||= []
    x.each_with_index do |y, j|
      case y
      when "."
        new_state[i][j] = "."
      when "L"
        count = [state[i-1][j], state[i-1][j+1], state[i][j+1], state[i+1][j+1], state[i+1][j], state[i+1][j-1], state[i][j-1], state[i-1][j-1]].select { |char| char == "#" }.count
        if count.zero?
          new_state[i][j] = "#"
        else
          new_state[i][j] = "L"
        end
      when "#"
        count = [state[i-1][j], state[i-1][j+1], state[i][j+1], state[i+1][j+1], state[i+1][j], state[i+1][j-1], state[i][j-1], state[i-1][j-1]].select { |char| char == "#" }.count
        if count > 3
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
