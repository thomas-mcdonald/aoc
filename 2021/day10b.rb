input = File.read("./day10.input").split("\n").map { |line| line.split("") }

mapping = {
  "[": "]",
  "{": "}",
  "<": ">",
  "(": ")"
}

completion_stacks = []

input.each do |row|
  stack = []
  chars = row.dup
  valid = true
  while !chars.empty? && valid
    char = chars.shift
    if ["[", "(", "{", "<"].include?(char)
      stack.push(char)
    else
      to_match = stack.pop
      if char != mapping[to_match.to_sym]
        valid = false
      end
    end
  end

  if valid
    completion_string = stack.map { |ch| mapping[ch.to_sym] }.reverse
    completion_stacks << completion_string
  end
end

scoring = {
  ")": 1,
  "]": 2,
  "}": 3,
  ">": 4
}

scores = completion_stacks.map do |chars|
  chars.reduce(0) { |acc, x| (acc * 5) + scoring[x.to_sym] }
end

## lol, integer division
puts scores.sort[scores.length / 2]
