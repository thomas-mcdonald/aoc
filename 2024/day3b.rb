require "strscan"

input = File.read("day3.input")

scan = StringScanner.new(input)
regex = /mul\((\d+)\,(\d+)\)|do\(\)|don\'t\(\)/
val = 0
multiplier = true
while match = scan.scan_until(regex)
  text = scan.matched
  case text
    when "do()"
      multiplier = true
    when "don't()"
      multiplier = false
    else
      group = scan.captures
      val += group[0].to_i * group[1].to_i if multiplier
  end
end
puts val
