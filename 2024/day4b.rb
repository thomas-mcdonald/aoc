input = File.read("day4.input").split("\n").map { |line| line.split("") }

count = 0
input.each_with_index do |line, i|
  next if i == 0 or i == input.length - 1
  line.each_with_index do |char, j|
    next if j == 0 or j == line.length - 1

    next unless input[i][j] == "A"
    tl = input[i - 1][j - 1]
    tr = input[i - 1][j + 1]
    bl = input[i + 1][j - 1]
    br = input[i + 1][j + 1]
    next unless (tl == "M") && (br == "S") || ((tl == "S") && (br == "M"))
    next unless (tr == "M") && (bl == "S") || ((tr == "S") && (bl == "M"))
    count += 1
  end
end

puts count
