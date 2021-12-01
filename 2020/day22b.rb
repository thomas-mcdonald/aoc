require "set"

input = File.read("./day22.input").split("\n\n").map do |deck|
  deck.split("\n")[1..].map(&:to_i)
end

# too high: 35083
# too low: 8827

$output_counter = 0

def play(p1, p2)
  state = Set.new

  while !p1.empty? && !p2.empty?
    return [[1], []] if state.include?([p1, p2].hash)
    state << [p1, p2].hash

    a = p1.shift
    b = p2.shift

    if p1.length >= a and p2.length >= b
      a1 = p1.take(a)
      b1 = p2.take(b)
      result = play(a1, b1)

      if result[0].length > 0
        p1 += [a, b]
      else
        p2 += [b, a]
      end
    elsif a > b
      p1 += [a, b]
    else
      p2 += [b, a]
    end
  end

  # puts "ending: #{decks.inspect}"
  [p1, p2]
end

decks = play(input[0].dup, input[1].dup)

puts decks.inspect

winner = decks[0].length > 0 ? decks[0] : decks[1]

puts winner.reverse.each_with_index.map { |val, idx| val * (idx + 1) }.sum
