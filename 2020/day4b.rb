input = File.read("./day4.input").split("\n\n").map do |pp|
  pp.split.map { |v| v.split(":") }.to_h
end

required_fields = %w(byr iyr eyr hgt hcl ecl pid)
eyes = %(amb blu brn gry grn hzl oth)

count = 0

input.each do |pp|
  valid = required_fields.all? { |field| pp.key?(field) }
  valid &= (1920..2002).include? pp["byr"].to_i
  valid &= (2010..2020).include? pp["iyr"].to_i
  valid &= (2020..2030).include? pp["eyr"].to_i
  valid &= begin
    field = pp["hgt"] || ""
    unit = field[-2..-1]
    value = field[0..-3].to_i
    case unit
    when "cm"
      (150..193).include? value
    when "in"
      (59..76).include? value
    else
      false
    end
  end
  valid &= /\A#[0-9a-f]{6}\Z/.match? pp["hcl"]
  valid &= eyes.include?(pp["ecl"] || "")
  valid &= /\A\d{9}\Z/.match? pp["pid"]

  count += 1 if valid
end

puts count
