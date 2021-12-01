input = File.read("./day1.input").split("\n").map(&:to_i)

count = 0

values = input.each_cons(3).map { |xs| xs.sum }

val = values.shift
values.each do |x|
  count += 1 if x > val
  val = x
end

puts count
