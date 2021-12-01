require "set"

result = File.read("./day6.input").split("\n\n").map do |group|
  group.split("\n").map { |str| str.split("") }.reduce(Set.new) { |arr, x| arr.union(x) }
end

puts result.reduce(0) { |arr, x| arr + x.length }
