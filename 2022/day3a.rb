input = File.read("./day3.input").split("\n")

cost = (("a".."z").to_a + ("A".."Z").to_a).zip(1..52).to_h

rucksacks = input.map do |line|
  midpoint = line.length / 2
  [line[..midpoint - 1], line[midpoint..]]
end

dupes = rucksacks.map do |rucksack|
  (rucksack[0].split("").uniq & rucksack[1].split("").uniq)[0]
end

puts dupes.map { |char| cost[char] }.sum
# puts dupes.inspect
