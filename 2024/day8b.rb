input = File.read("day8.input").strip.split("\n").map { |line| line.split("") }

chars = Set.new(input.flat_map { |line| line.uniq }) - Set.new(["."])

antinodes = Set.new()
max_x = input.length
chars.each do |char|
  char_locations = Set.new()
  input.each_with_index do |line, x|
    line.each_with_index do |c, y|
      char_locations << [x, y] if c == char
    end
  end

  locs = char_locations.to_a
  locs.product(locs).each do |(x1, y1), (x2, y2)|
    next if x1 == x2 && y1 == y2

    distance_between_x = (x1 - x2)
    distance_between_y = (y1 - y2)
    divisor = distance_between_x.gcd(distance_between_y)
    step_x = distance_between_x / divisor
    step_y = distance_between_y / divisor
    antinodes << [x1, y1]
    antinodes << [x2, y2]
    loop do
      x1 += step_x
      y1 += step_y
      if x1 < 0 || x1 >= max_x || y1 < 0 || y1 >= max_x
        break
      end
      antinodes << [x1, y1]
    end


    loop do
      x2 -= step_x
      y2 -= step_y
      if x2 < 0 || x2 >= max_x || y2 < 0 || y2 >= max_x
        break
      end
      antinodes << [x2, y2]
    end
    # location_1 = [x1 + distance_between_x, y1 + distance_between_y]
    # location_2 = [x2 - distance_between_x, y2 - distance_between_y]
    # antinodes << location_1 unless location_1[0] < 0 || location_1[0] >= max_x || location_1[1] < 0 || location_1[1] >= max_x
    # antinodes << location_2 unless location_2[0] < 0 || location_2[0] >= max_x || location_2[1] < 0 || location_2[1] >= max_x
  end
end

puts antinodes.length
