require "set"

input = File.read("day6.input").strip.split("\n").map { |xs| xs.split("") }

initial_x = input.find_index { |xs| xs.include?("^") }
initial_y = input[initial_x].find_index { |x| x == "^" }

visited = Set.new
guard = [initial_x, initial_y]
direction = "up"

loop do
  visited.add(guard)
  x, y = guard
  case direction
  when "up"
    break if x == 0
    if input[x - 1][y] == "#"
      direction = "right"
      guard = [x, y + 1]
    else
      guard = [x - 1, y]
    end
  when "right"
    break if y == input[x].size - 1
    if input[x][y + 1] == "#"
      direction = "down"
      guard = [x + 1, y]
    else
      guard = [x, y + 1]
    end
  when "down"
    break if x == input.size - 1
    if input[x + 1][y] == "#"
      direction = "left"
      guard = [x, y - 1]
    else
      guard = [x + 1, y]
    end
  when "left"
    break if y == 0
    if input[x][y - 1] == "#"
      direction = "up"
      guard = [x - 1, y]
    else
      guard = [x, y - 1]
    end
  end
end

guard = [initial_x, initial_y]
direction = "up"

loop_count = 0
loop_locations = Set.new()
visited.each do |path_x, path_y|
  next if path_x == initial_x && path_y == initial_y
  temp_array = Marshal.load(Marshal.dump(input))
  temp_array[path_x][path_y] = "#"

  visited_with_direction = Set.new
  guard = [initial_x, initial_y]
  direction = "up"

  loop do
    if visited_with_direction.include?([guard, direction])
      print "looping at #{guard}, #{direction}\n"
      loop_count += 1
      loop_locations.add([path_x, path_y])
      break
    end
    visited_with_direction.add([guard, direction])

    x, y = guard
    case direction
    when "up"
      break if x == 0
      if temp_array[x - 1][y] == "#"
        direction = "right"
      else
        guard = [x - 1, y]
      end
    when "right"
      break if y == temp_array[x].size - 1
      if temp_array[x][y + 1] == "#"
        direction = "down"
      else
        guard = [x, y + 1]
      end
    when "down"
      break if x == temp_array.size - 1
      if temp_array[x + 1][y] == "#"
        direction = "left"
      else
        guard = [x + 1, y]
      end
    when "left"
      break if y == 0
      if temp_array[x][y - 1] == "#"
        direction = "up"
      else
        guard = [x, y - 1]
      end
    end
  end
end

puts loop_count
puts loop_locations.count


# old attempt at injecting an obstacle at x steps into the path
# 6220.times do |i|
#   next if i == 0
#   temp_array = Marshal.load(Marshal.dump(input))


#   inject_stopper_at = i
#   current_step = 0
#   inject_location = nil
#   loop do
#     x, y = guard
#     if current_step == inject_stopper_at
#       print "injecting at #{x}, #{y} with direction #{direction}\n"
#       case direction
#       when "up"
#         break if x == 0
#         temp_array[x - 1][y] = "#"
#         inject_location = [x - 1, y]
#       when "right"
#         break if y == temp_array[x].size - 1
#         temp_array[x][y + 1] = "#"
#         inject_location = [x, y + 1]
#       when "down"
#         break if x == temp_array.size - 1
#         temp_array[x + 1][y] = "#"
#         inject_location = [x + 1, y]
#       when "left"
#         break if y == 0
#         temp_array[x][y - 1] = "#"
#         inject_location = [x, y - 1]
#       end
#     end
#     current_step += 1
#     if visited_with_direction.include?([guard, direction])
#       print "looping at #{guard}, #{direction}, #{current_step}\n"
#       loop_count += 1
#       loop_locations.add(inject_location)
#       break
#     end
#     visited_with_direction.add([guard, direction])
#     case direction
#     when "up"
#       break if x == 0
#       if temp_array[x - 1][y] == "#"
#         direction = "right"
#         guard = [x, y + 1]
#       else
#         guard = [x - 1, y]
#       end
#     when "right"
#       break if y == temp_array[x].size - 1
#       if temp_array[x][y + 1] == "#"
#         direction = "down"
#         guard = [x + 1, y]
#       else
#         guard = [x, y + 1]
#       end
#     when "down"
#       break if x == temp_array.size - 1
#       if temp_array[x + 1][y] == "#"
#         direction = "left"
#         guard = [x, y - 1]
#       else
#         guard = [x + 1, y]
#       end
#     when "left"
#       break if y == 0
#       if temp_array[x][y - 1] == "#"
#         direction = "up"
#         guard = [x - 1, y]
#       else
#         guard = [x, y - 1]
#       end
#     end
#   end
# end

# puts loop_count
# puts loop_locations.count
