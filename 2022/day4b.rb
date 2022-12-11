input = File.read("./day4.input")
  .split("\n")
  .map { |line| line.split(",")
  .map { |assign| Range.new(*assign.split("-").map(&:to_i)) } }

res = input.select do |pair|
  x, y = pair
  ((x.first <= y.last) and (y.first <= x.last)) || ((y.first <= x.last) and (x.first <= y.last))
end

puts res.count
