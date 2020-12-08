require "set"

input = File.read("./day8.input").split("\n").map { |row| row.split(" ") }

input.length.times do |i|
  program = input.dup
  case program[i][0]
  when "nop"
    program[i] = ["jmp", program[i][1]]
  when "jmp"
    program[i] = ["nop", program[i][1]]
  end

  pc = 0
  acc = 0
  visited = Set.new

  loop do
    break if visited.include?(pc)
    visited << pc

    if pc == program.length
      puts acc
      break
    end

    op = program[pc][0]
    arg = program[pc][1].to_i
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
end
