require "set"

input = File.read("./day8.input").split("\n").map { |row| row.split(" ") }

pc = 0
acc = 0
visited = Set.new

loop do
  break if visited.include?(pc)
  visited << pc
  op = input[pc][0]
  arg = input[pc][1].to_i
  case op
  when "nop"
    pc += 1
  when "acc"
    acc += arg
    pc += 1
  when "jmp"
    pc += arg
  end
end

puts acc
