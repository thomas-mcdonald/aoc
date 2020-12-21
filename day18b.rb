require "strscan"

input = File.read("./day18.input").split("\n")

# for part b, core process of attempting to resolve parenthesis is still valid
# once we hit a block with no parenthesis, pull out additions and resolve
def parse(substring)
  if substring.include?("(")
    # future interviewers: not my usual code
    # grab the smallest chunk of parenthesis we can and parse that value
    parens = substring.match(/\(([^\(\)]*)\)/)
    resolved_value = parse(parens[1]).to_s
    update = substring.gsub(parens.to_s, resolved_value)
    parse(update)
  elsif substring.include?("+")
    match = substring.match(/(\d+) \+ (\d+)/)
    update = eval(match.to_s).to_s
    parse(substring.sub(match.to_s, update))
  else
    eval(substring)
  end
end

total = input.map do |string|
  parse(string)
end.map(&:to_i).sum

puts total
