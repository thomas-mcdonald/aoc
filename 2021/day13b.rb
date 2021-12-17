input = File.read("./day13.input").split("\n\n")

dots = input[0].split("\n").map { |line| line.split(",").map(&:to_i) }
folds = input[1].split("\n").map do |fold|
  match = fold.match(/fold along (.)=(\d+)/)
  [match[1], match[2].to_i]
end

folds.each do |fold|
  midpoint = fold[1]
  dots = dots.map do |dot|
    case fold[0]
    when "y"
      if dot[1] == midpoint
        nil
      elsif dot[1] < midpoint
        dot
      else
        [dot[0], midpoint - (dot[1] - midpoint)]
      end
    when "x"
      if dot[0] == midpoint
        nil
      elsif dot[0] < midpoint
        dot
      else
        [midpoint - (dot[0] - midpoint), dot[1]]
      end
    end
  end.compact

  puts dots[1].inspect
end

max_x = dots.map { |dot| dot[0] }.max + 1
max_y = dots.map { |dot| dot[1] }.max + 1

paper = max_x.times.map do |i|
  max_y.times.map { |j| " " }
end.transpose

dots.each do |dot|
  paper[dot[1]][dot[0]] = "#"
end

puts "\n\n"
paper.each { |line| puts line.join(" ") }

# folds.each do |fold|
#   case fold[0]
#   when "x"
#     f = fold[1]
#     existing = paper.map { |row| row[...f] }
#     folding = paper.map { |row| row[f...].reverse }
#     puts [existing.length, folding.length].inspect
#     paper = existing.each_with_index.map do |line, i|
#       line.each_with_index.map do |val, j|
#         if val == "#" || folding[i][j] == "#"
#           "#"
#         else
#           " "
#         end
#       end
#     end
#   when "y"
#     existing = paper[...fold[1]].reverse
#     folding = paper[fold[1]...]
#     # puts [existing.length, folding.length].inspect
#     paper = existing.each_with_index.map do |line, i|
#       line.each_with_index.map do |val, j|
#         if val == "#" || folding[i][j] == "#"
#           "#"
#         else
#           " "
#         end
#       end
#     end.reverse
#   end
#   # puts "\n\n"
#   # paper.each { |line| puts line.join(" ") }

# end

# puts "\n\n"
# paper.each { |line| puts line.join(" ") }
