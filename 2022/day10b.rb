input = File.read("./day10.input").split("\n").map { |line| line.split(" ") }

pc = 0
x = [1]

while input.length > 0
  instr = input.shift
  case instr[0]
  when "noop"
    x << x.last
  when "addx"
    x << x.last
    x << x.last + instr[1].to_i
  end
end

location = 0
output = []

while location < x.length
  place = location % 40
  covered = (x[location] - 1)..(x[location] + 1)
  if covered.include?(place)
    output << "#"
  else
    output << "."
  end

  location += 1
end

output.each_slice(40) do |slice|
  puts slice.join(" ")
end
