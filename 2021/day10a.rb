input = File.read("./day10.input").split("\n").map { |line| line.split("") }

mapping = {
  "[": "]",
  "{": "}",
  "<": ">",
  "(": ")"
}

invalid_chars = []

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
        invalid_chars << char
      end
    end
  end
end

scoring = {
  ")": 3,
  "]": 57,
  "}": 1197,
  ">": 25137
}

score = invalid_chars.map { |ch| scoring[ch.to_sym] }.sum
puts score
