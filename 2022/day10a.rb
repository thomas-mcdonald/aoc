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

count = x.length / 40
interesting = []
count.times.each do |i|

  interesting << x[(i * 40) + 20 - 1] * ((i * 40) + 20)
end

puts interesting.sum
