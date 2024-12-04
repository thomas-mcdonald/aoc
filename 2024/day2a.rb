input = File.read("day2.input").split("\n").map { |line| line.split(" ").map(&:to_i) }

match_lines = input.select do |line|
  safe_diff = line.each_with_index.all? do |x, i|
    next true if i == 0
    ((line[i] - line[i - 1]).abs >= 1) && ((line[i] - line[i - 1]).abs <= 3)
  end

  increasing = line.each_with_index.all? do |x, i|
    next true if i == 0
    line[i] > line[i - 1]
  end

  decreasing = line.each_with_index.all? do |x, i|
    next true if i == 0
    line[i - 1] > line[i]
  end

  # puts "#{line} #{safe_diff} #{increasing} #{decreasing}"
  safe_diff && (increasing || decreasing)
end

puts match_lines.count
