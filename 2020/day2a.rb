input = File.read("./day2.input").split("\n")

count = 0

input.each do |row|
  components = row.split(" ")
  lower, upper = components[0].split("-").map(&:to_i)
  range = (lower..upper)
  char = components[1][0]
  password = components[2]
  count += 1 if range.include? password.count(char)
end

puts count
