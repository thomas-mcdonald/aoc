input = File.read("./day5.input").split("\n").map do |line|
  line.split(" -> ").map { |tup| tup.split(",").map(&:to_i) }
end

def points_to_line(points)
  if points[0][0] == points[1][0]
    range = Range.new(*[points[0][1], points[1][1]].sort)
    range.map { |x| [points[0][0], x] }
  elsif points[0][1] == points[1][1]
    range = Range.new(*[points[0][0], points[1][0]].sort)
    range.map { |x| [x, points[0][1]] }
  else
    # sort points so we're only dealing with two types of diags
    # up and to right
    # down and to right
    start = points.min_by { |tup| tup[0] }
    finish = points.max_by { |tup| tup[0] }

    if start[1] > finish[1]
      (start[0]..finish[0]).each_with_index.map { |x, idx| [x, start[1] - idx] }
    else
      (start[0]..finish[0]).each_with_index.map { |x, idx| [x, start[1] + idx] }
    end
  end
end

lines = input.map { |line| points_to_line(line) }.compact

tl = [0, 0]
br_x = input.map { |points| [points[0][0], points[1][0]] }.flatten.max
br_y = input.map { |points| [points[0][1], points[1][1]] }.flatten.max
br = [br_x, br_y]

diagram = (br_x + 1).times.map do |i|
  Array.new(br_y + 1) { |z| 0 }
end

lines.each do |line|
  line.each do |point|
    diagram[point[0]][point[1]] += 1
  end
end

puts diagram.map { |row| row.select { |count| count > 1 }.length }.sum
