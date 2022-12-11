input = File.read("./day4.input")
  .split("\n")
  .map { |line| line.split(",")
  .map { |assign| Range.new(*assign.split("-").map(&:to_i)) } }

res = input.select do |pair|
  x, y = pair
  ((x.first <= y.first) && (x.last >= y.last)) || ((y.first <= x.first) && (y.last >= x.last))
end

puts res.count
