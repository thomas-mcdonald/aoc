input = File.read("./day1.input").split("\n").map(&:to_i)

count = 0
val = input.shift

input.each do |x|
  count += 1 if x > val
  val = x
end

puts count
