input = File.read("./day2.input").split("\n")

count = 0

input.each do |row|
  components = row.split(" ")
  lower, upper = components[0].split("-").map(&:to_i)
  char = components[1][0]
  password = components[2]
  valid = (password[lower - 1] == char) ^ (password[upper - 1] == char)
  count += 1 if valid
end

puts count
