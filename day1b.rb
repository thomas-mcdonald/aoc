input = File.read("./day1.input").split("\n").map(&:to_i)

arr = input.product(input, input)

arr.each do |x, y, z|
  if x + y + z == 2020
    puts "#{x} + #{y} + #{z}"
    puts x * y * z
    break
  end
end
