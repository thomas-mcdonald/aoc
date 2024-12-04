require "strscan"

input = File.read("day3.input")

scan = StringScanner.new(input)
regex = /mul\((\d+)\,(\d+)\)/
val = 0
while match = scan.scan_until(regex)
  group = scan.captures
  val += group[0].to_i * group[1].to_i
end
puts val
