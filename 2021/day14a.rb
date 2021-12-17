require "strscan"

input = File.read("./day14.input").split("\n\n")

seed = input[0]
instructions = input[1].split("\n").map { |ins| ins.split(" -> ") }.to_h

pc = 0
value = seed
while pc < 10
  scan = StringScanner.new(value)
  new_string = ""
  a = nil
  b = scan.getch
  while !scan.eos?
    a = b
    b = scan.getch
    new_char = instructions["#{a}#{b}"]
    new_string << "#{a}#{new_char}"
  end
  new_string << b
  value = new_string
  pc += 1
end

char_counts = value.split("").tally
max_ch = char_counts.max_by { |_k, v| v }[1]
min_ch = char_counts.min_by { |_k, v| v }[1]

puts max_ch - min_ch
