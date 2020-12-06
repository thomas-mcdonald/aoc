require "set"

result = File.read("./day6.input").split("\n\n").map do |group|
  group.split("\n").map { |str| Set.new(str.split("")) }.reduce(:&)
end

puts result.reduce(0) { |arr, x| arr + x.length }
