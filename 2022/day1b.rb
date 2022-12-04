input = File.read("./day1.input")

puts input.split("\n\n").map { |elf| elf.split("\n").map(&:to_i) }.map(&:sum).sort.reverse[0..2].sum
