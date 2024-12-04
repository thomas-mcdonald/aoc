require "set"
require "strscan"

input = File.read("day4.input").split("\n").map { |line| line.split("") }


count = 0
spots = Set.new()
input.each_with_index do |line, i|
  line.each_with_index do |char, j|
    if line.length - 4 >= j && line[j] == "X" && line[j + 1] == "M" && line[j + 2] == "A" && line[j + 3] == "S"
      spots = spots.merge([[i, j], [i, j + 1], [i, j + 2], [i, j + 3]])
      count += 1
    end
    if line.length - 4 >= j && line[j] == "S" && line[j + 1] == "A" && line[j + 2] == "M" && line[j + 3] == "X"
      spots = spots.merge([[i, j], [i, j + 1], [i, j + 2], [i, j + 3]])
      count += 1
    end
    if input.length - 4 >= i && input[i][j] == "X" && input[i + 1][j] == "M" && input[i + 2][j] == "A" && input[i + 3][j] == "S"
      spots = spots.merge([[i, j], [i + 1, j], [i + 2, j], [i + 3, j]])
      count += 1
    end
    if input.length - 4 >= i && input[i][j] == "S" && input[i + 1][j] == "A" && input[i + 2][j] == "M" && input[i + 3][j] == "X"
      spots = spots.merge([[i, j], [i + 1, j], [i + 2, j], [i + 3, j]])
      count += 1
    end
    if input.length - 4 >= i && line.length - 4 >= j && input[i][j] == "X" && input[i + 1][j + 1] == "M" && input[i + 2][j + 2] == "A" && input[i + 3][j + 3] == "S"
      spots = spots.merge([[i, j], [i + 1, j + 1], [i + 2, j + 2], [i + 3, j + 3]])
      count += 1
    end
    if input.length - 4 >= i && line.length - 4 >= j && input[i][j] == "S" && input[i + 1][j + 1] == "A" && input[i + 2][j + 2] == "M" && input[i + 3][j + 3] == "X"
      spots = spots.merge([[i, j], [i + 1, j + 1], [i + 2, j + 2], [i + 3, j + 3]])
      count += 1
    end
    if input.length - 4 >= i && 3 <= j && input[i][j] == "X" && input[i + 1][j - 1] == "M" && input[i + 2][j - 2] == "A" && input[i + 3][j - 3] == "S"
      spots = spots.merge([[i, j], [i + 1, j - 1], [i + 2, j - 2], [i + 3, j - 3]])
      count += 1
    end
    if input.length - 4 >= i && 3 <= j && input[i][j] == "S" && input[i + 1][j - 1] == "A" && input[i + 2][j - 2] == "M" && input[i + 3][j - 3] == "X"
      spots = spots.merge([[i, j], [i + 1, j - 1], [i + 2, j - 2], [i + 3, j - 3]])
      count += 1
    end
  end
end

input.each_with_index do |line, i|
  line = line.each_with_index.map do |char, j|
    if spots.include?([i, j])
      char
    else
      "."
    end
  end
  puts line.join("")
end

puts count
