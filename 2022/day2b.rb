input = File.read("./day2.input").split("\n")

score = {
  r: 1,
  p: 2,
  s: 3
}

res = input.map do |row|
  case row
  when "A X"
    0 + score[:s]
  when "A Y"
    3 + score[:r]
  when "A Z"
    6 + score[:p]
  when "B X"
    0 + score[:r]
  when "B Y"
    3 + score[:p]
  when "B Z"
    6 + score[:s]
  when "C X"
    0 + score[:p]
  when "C Y"
    3 + score[:s]
  when "C Z"
    6 + score[:r]
  end
end.sum

puts res
