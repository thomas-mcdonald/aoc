input = File.read("./day3.input").split("\n").map { |str| str.split("").map(&:to_i) }

gamma = input.transpose.map do |row|
  row.max_by { |e| row.count(e) }
end.join("").to_i(2)

epsilon = input.transpose.map do |row|
  row.min_by { |e| row.count(e) }
end.join("").to_i(2)

puts gamma * epsilon
