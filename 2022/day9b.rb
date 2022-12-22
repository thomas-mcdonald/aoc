require "set"

input = File.read("./day9.input").split("\n").map { |line| line.split(" ") }

knots = 10.times.map { |x| [0, 0] }
locations = Set.new

while input.length > 0
  instruction = input.shift
  direction = instruction[0]
  size = instruction[1].to_i
  while size > 0
    head_position = knots[0]

    size -= 1
    case direction
    when "R"
      head_position = [head_position[0], head_position[1] + 1]
    when "L"
      head_position = [head_position[0], head_position[1] - 1]
    when "U"
      head_position = [head_position[0] + 1, head_position[1]]
    when "D"
      head_position = [head_position[0] - 1, head_position[1]]
    end

    knots[0] = head_position

    9.times do |i|
      head_position = knots[i]
      tail_position = knots[i + 1]

      valid_vertical = [head_position[0] - 1, head_position[0], head_position[0] + 1]
      valid_horiz = [head_position[1] - 1, head_position[1], head_position[1] + 1]
      if valid_vertical.include?(tail_position[0]) && valid_horiz.include?(tail_position[1])
        # do nothing
      else
        if head_position[0] != tail_position[0]
          if head_position[0] > tail_position[0]
            tail_position = [tail_position[0] + 1, tail_position[1]]
          else
            tail_position = [tail_position[0] - 1, tail_position[1]]
          end
        end

        if head_position[1] != tail_position[1]
          if head_position[1] > tail_position[1]
            tail_position = [tail_position[0], tail_position[1] + 1]
          else
            tail_position = [tail_position[0], tail_position[1] - 1]
          end
        end
      end

      knots[i + 1] = tail_position
    end

    locations << knots[9]
  end
end

puts locations.length
