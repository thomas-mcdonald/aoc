rules, my_ticket, other_tickets = File.read("./day16.input").split("\n\n")

puts rules.inspect
puts my_ticket.inspect
puts other_tickets.inspect

# this parsing code is not my finest, but short of writing a parser...
rules = rules.split("\n").map do |rule|
  defn = rule.split(": ")
  # every rule only has one or clause...
  defn[1] = defn[1].split(" or ").map { |part| part.split("-").map(&:to_i) }.map { |int_parts| (int_parts[0]..int_parts[1]) }
  defn
end

other_tickets = other_tickets.split("\n").map { |ticket| ticket.split(",").map(&:to_i) }
other_tickets.shift

invalid_values = 0

other_tickets.each do |ticket|
  ticket.each do |value|
    valid_value = rules.any? do |rule|
      rule[1].any? { |range| range.include?(value) }
    end

    invalid_values += value unless valid_value
  end
end

puts invalid_values
