input = File.read("./day3.input").split("\n")

cost = (("a".."z").to_a + ("A".."Z").to_a).zip(1..52).to_h

badges = input.each_slice(3).map do |block|
  (block[0].split("").uniq & block[1].split("").uniq & block[2].split("").uniq)[0]
end

puts badges.map { |char| cost[char] }.sum
