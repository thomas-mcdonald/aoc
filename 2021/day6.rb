input = File.read("./day6.input").split(",").map(&:to_i)

fish = input.tally

def tick(fish)
  # decrement all timers except for 0, special case that
  new_fish_count = fish.delete(0)
  fish = fish.map do |k, v|
    [k-1,v]
  end.to_h

  if new_fish_count
    fish[6] ||= 0
    fish[6] += new_fish_count
    fish[8] = new_fish_count
  end

  fish
end

256.times do
  fish = tick(fish)
end

puts fish.values.sum
