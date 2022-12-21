input = File.read("./day8.input").split("\n").map { |row| row.split("").map(&:to_i) }

visible = 0

def count_start_of_array(arr)
  valid = true
  idx = 0
  while valid && idx < arr.length
    valid &= arr[idx]
    idx += 1
  end

  idx
end

max_value = 0

input.each_with_index do |line, i|
  line.each_with_index do |tree, j|
    up_count = i
    up_visible = up_count.times.to_a.map { |x| input[x][j] < tree }.reverse
    up = count_start_of_array(up_visible)

    down_count = input.length - i - 1
    down_visible = down_count.times.to_a.map { |x| input[x + i + 1][j] < tree }
    down = count_start_of_array(down_visible)

    left_count = j
    left_visible = left_count.times.to_a.map { |x| input[i][x] < tree }.reverse
    left = count_start_of_array(left_visible)

    right_count = input[0].length - j - 1
    right_visible = right_count.times.to_a.map { |x| input[i][x + j + 1] < tree }
    right = count_start_of_array(right_visible)

    value = up * down * left * right
    max_value = [value, max_value].max
  end
end

puts max_value
