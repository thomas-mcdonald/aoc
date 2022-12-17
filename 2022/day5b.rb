input = [
  %w(s m r n w j v t),
  %w(b w d j q p c v),
  %w(b j f h d r p),
  %w(f r p b m n d),
  %w(h v r p t b),
  %w(c b p t),
  %w(b j r p l),
  %w(n c s l t z b w),
  %w(l s g)
]

instructions = File.read("./day5.input").split("\n\n")[1].split("\n").map do |line|
  parts = line.split(" ")
  {
    count: parts[1].to_i,
    from: parts[3].to_i,
    to: parts[5].to_i
  }
end

state = input.dup

while instructions.length > 0
  instruction = instructions.shift
  moving = state[instruction[:from] - 1].pop(instruction[:count])
  state[instruction[:to] - 1] = state[instruction[:to] - 1].concat(moving)
end

puts state.map { |stack| stack.last }.join("")
