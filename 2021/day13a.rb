input = File.read("./day13.input").split("\n\n")

dots = input[0].split("\n").map { |line| line.split(",").map(&:to_i) }
folds = input[1].split("\n").map do |fold|
  match = fold.match(/fold along (.)=(\d+)/)
  [match[1], match[2].to_i]
end

max_x = dots.map { |dot| dot[0] }.max + 1
max_y = dots.map { |dot| dot[1] }.max + 1

paper = max_x.times.map do |i|
  max_y.times.map { |j| "." }
end

dots.each do |dot|
  paper[dot[0]][dot[1]] = "#"
end

fold = folds.first
case fold[0]
when "x"
  existing = paper[0..(fold[1] - 1)]
  folding = paper[(fold[1] + 1)..].reverse
  res = existing.each_with_index.map do |line, i|
    line.each_with_index.map do |val, j|
      if val == "#" || folding[i][j] == "#"
        "#"
      else
        "."
      end
    end
  end
  puts res.map { |line| line.select { |char| char == "#" }}.map(&:count).sum
when "y"
end
