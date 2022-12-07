input = File.read("./day2.input").split("\n")

res = input.map do |row|
  case row
  when "A X"
    1 + 3
  when "A Y"
    2 + 6
  when "A Z"
    3 + 0
  when "B X"
    1 + 0
  when "B Y"
    2 + 3
  when "B Z"
    3 + 6
  when "C X"
    1 + 6
  when "C Y"
    2 + 0
  when "C Z"
    3 + 3
  end
end.sum

puts res
