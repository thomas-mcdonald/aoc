input = File.read("./day8.input").split("\n").map { |row| row.split("").map(&:to_i) }

visible = 0

input.each_with_index do |line, i|
  line.each_with_index do |tree, j|
    up_count = i
    up_visible = up_count.times.to_a.all? { |x| input[x][j] < tree }

    down_count = input.length - i - 1
    down_visible = down_count.times.to_a.all? { |x| input[x + i + 1][j] < tree }

    left_count = j
    left_visible = left_count.times.to_a.all? { |x| input[i][x] < tree }

    right_count = input[0].length - j - 1
    right_visible = right_count.times.to_a.all? { |x| input[i][x + j + 1] < tree }

    visible += 1 if up_visible || down_visible || left_visible || right_visible
  end
end

puts visible
