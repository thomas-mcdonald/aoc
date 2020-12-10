input = File.read("./day9.input").split("\n").map(&:to_i)

target = 675280050
i = 0
j = 0

loop do
  current = input[i..j].sum

  if current == target
    min = input[i..j].min
    max = input[i..j].max
    puts [min, max].inspect
    puts min + max
    break
  elsif current < target
    j += 1
  elsif current > target
    i += 1
    j = i
  end
end
