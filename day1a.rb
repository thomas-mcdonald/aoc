input = File.read("./day1.input").split("\n").map(&:to_i)

arr = input.product(input)

arr.each do |x, y|
  next unless x + y == 2020

  puts "#{x} + #{y}"
  puts x * y
  break
end
