require "set"

input = File.read("./day11.input").split("\n").map { |line| line.split("").map(&:to_i) }

board = input
ticks = 0
continue = true

while continue
  ticks += 1
  new_board = board.dup

  new_board = new_board.map do |line|
    line.map do |num|
      num + 1
    end
  end

  flashed = Set.new

  while new_board.each_with_index.any? { |line, x| line.each_with_index.any? { |num, y| num > 9 and !flashed.include?([x, y]) } }
    new_board.each_with_index do |line, x|
      line.each_with_index do |num, y|
        next unless num > 9 and !flashed.include?([x, y])

        flashed << [x, y]
        new_board[x - 1][y - 1] += 1 if x - 1 >= 0 && y - 1 >= 0
        new_board[x][y - 1] += 1 if y - 1 >= 0
        new_board[x + 1][y - 1] += 1 if x + 1 < new_board.length && y - 1 >= 0
        new_board[x - 1][y] += 1 if x - 1 >= 0
        new_board[x + 1][y] += 1 if x + 1 < new_board.length
        new_board[x - 1][y + 1] += 1 if x - 1 >= 0 && y + 1 < new_board[0].length
        new_board[x][y + 1] += 1 if y + 1 < new_board[0].length
        new_board[x + 1][y + 1] += 1 if x + 1 < new_board.length && y + 1 < new_board[0].length
      end
    end
  end

  flashed.each do |point|
    new_board[point[0]][point[1]] = 0
  end

  if flashed.length == 100
    continue = false
  end

  board = new_board
end

puts ticks
