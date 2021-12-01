input = File.read("./day22.input").split("\n\n").map do |deck|
  deck.split("\n")[1..].map(&:to_i)
end

decks = input.dup

while !decks[0].empty? && !decks[1].empty?
  a = decks[0].shift
  b = decks[1].shift
  if a > b
    decks[0].push(a, b)
  else
    decks[1].push(b, a)
  end
end

winner = decks[0].length > 0 ? decks[0] : decks[1]

puts winner.reverse.each_with_index.map { |val, idx| val * (idx + 1) }.sum
