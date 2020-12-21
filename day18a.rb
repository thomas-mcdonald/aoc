require "strscan"

input = File.read("./day18.input").split("\n")

def parse(substring)
  if substring.include?("(")
    # future interviewers: not my usual code
    # grab the smallest chunk of parenthesis we can and parse that value
    parens = substring.match(/\(([^\(\)]*)\)/)
    resolved_value = parse(parens[1]).to_s
    update = substring.gsub(parens.to_s, resolved_value)
    parse(update)
  else
    parts = substring.split(" ")
    total = parts.shift.to_i
    while !parts.empty?
      # friends dont let friends do this
      total = total.send(parts[0], parts[1].to_i)
      parts.shift(2)
    end
    total
  end
end

total = input.map do |string|
  parse(string)
end.map(&:to_i).sum

puts total
