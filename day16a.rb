rules, my_ticket, other_tickets = File.read("./day16.input").split(/\n\n.*:\n/)

puts rules.inspect
puts my_ticket.inspect
puts other_tickets.inspect

# this parsing code is not my finest, but short of writing a parser...
rules = rules.split("\n").map do |rule|
  label, defn = rule.split(": ")
  defn = defn.split(" or ").map { |part| part.split("-").map(&:to_i) }.map { |int_parts| (int_parts[0]..int_parts[1]) }
  [label, defn]
end.to_h

other_tickets = other_tickets.split("\n").map { |ticket| ticket.split(",").map(&:to_i) }

invalid_values = 0
ranges = rules.values.flatten

other_tickets.each do |ticket|
  ticket.each do |value|
    invalid_values += value unless ranges.any? { |range| range.include?(value) }
  end
end

puts invalid_values
