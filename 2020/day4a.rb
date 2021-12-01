input = File.read("./day4.input").split("\n\n").map do |pp|
  pp.split.map { |v| v.split(":") }.to_h
end

required_fields = %w(byr iyr eyr hgt hcl ecl pid)

count = 0

input.each do |pp|
  count += 1 if required_fields.all? { |field| pp.key?(field) }
end

puts count
