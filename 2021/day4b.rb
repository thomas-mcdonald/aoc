input = File.read("./day4.input").split("\n\n")

drawing_queue = input.shift.split(",").map(&:to_i)
boards = input.map { |board| board.split("\n").map { |row| row.split(/\s+/).reject { |s| s == "" }.map(&:to_i) } }

def marked_board(board, selected)
  board.map do |row|
    row.map { |num| selected.include?(num) }
  end
end

def has_won(board, selected)
  drawn_board = marked_board(board, selected)

  horizontals = drawn_board.any? { |row| row.all? }
  verticals = drawn_board.transpose.any? { |row| row.all? }
  # diagonal_1 = drawn_board.length.times.all? { |idx| drawn_board[idx][idx] }
  # diagonal_2 = drawn_board.length.times.all? { |idx| drawn_board[drawn_board.length - 1 - idx][idx] }
  [horizontals, verticals].any?
end

selected_numbers = []
winners = []

while winners.length < boards.length
  selected_numbers << drawing_queue.shift
  boards.each_with_index do |board, idx|
    next if winners.include?(idx)
    if has_won(board, selected_numbers)
      winners << idx
    end
  end
end

winner = boards[winners.last]
drawn_board = marked_board(winner, selected_numbers)

sum = 0
winner.each_with_index do |row, i|
  row.each_with_index do |num, j|
    sum += num unless drawn_board[i][j]
  end
end
puts sum * selected_numbers.last
