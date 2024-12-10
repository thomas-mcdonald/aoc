input = File.read("day10.input").strip.split("\n").map { |xs| xs.split("").map(&:to_i) }


trailheads = []
input.each_with_index do |row, x|
  row.each_with_index do |val, y|
    if val == 0
      trailheads << [x, y]
    end
  end
end

score = trailheads.map do |trailhead|
  peaks = Set.new # b solution is to just make this an array
  work = []
  work << trailhead
  while work.any?
    x, y = work.shift
    val = input[x][y]

    if val == 9
      peaks << [x, y]
    end

    work << [x + 1, y] if x + 1 < input.size && input[x + 1][y] == val + 1
    work << [x - 1, y] if x - 1 >= 0 && input[x - 1][y] == val + 1
    work << [x, y + 1] if y + 1 < input[0].size && input[x][y + 1] == val + 1
    work << [x, y - 1] if y - 1 >= 0 && input[x][y - 1] == val + 1
  end
  peaks.size
end

puts score.sum
