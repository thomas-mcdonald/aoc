require "set"

rules, my_ticket, other_tickets = File.read("./day16.input").split("\n\n")

# this parsing code is not my finest, but short of writing a parser...
rules = rules.split("\n").map do |rule|
  defn = rule.split(": ")
  # every rule only has one or clause...
  defn[1] = defn[1].split(" or ").map { |part| part.split("-").map(&:to_i) }.map { |int_parts| (int_parts[0]..int_parts[1]) }
  defn
end.to_h

my_ticket = my_ticket.split("\n")[1].split(",").map(&:to_i)

other_tickets = other_tickets.split("\n").map { |ticket| ticket.split(",").map(&:to_i) }
other_tickets.shift

valid_tickets = other_tickets.select do |ticket|
  ticket.all? do |value|
    rules.any? do |_k, rule|
      rule.any? { |range| range.include?(value) }
    end
  end
end

possible_mapping = []
valid_tickets[0].length.times { |i| possible_mapping[i] = rules.keys }

# there's probably a clever condition you could apply
# where you only do this until you have a valid list
(valid_tickets + [my_ticket]).each do |ticket|
  ticket.each_with_index do |val, col|
    potential_rules = possible_mapping[col]
    valid_rules = potential_rules.select do |rule_name|
      rule_def = rules[rule_name]
      rule_def.any? { |range| range.include?(val) }
    end
    possible_mapping[col] = valid_rules
  end
end

# any element of mapping with a single possible rule has been resolved
# these can be removed and excluded as candidates from other column mappings
# do this until all columns are single length
completed_rules = Set.new
rule_to_remove = possible_mapping.find { |rules| rules.length == 1 }[0]
while possible_mapping.any? { |rules| rules.length > 1 }
  possible_mapping = possible_mapping.map do |rules|
    next rules if rules.length == 1
    rules.reject { |r| r == rule_to_remove }
  end
  completed_rules << rule_to_remove
  rule_to_remove = possible_mapping.find { |rules| rules.length == 1 and !completed_rules.include?(rules[0] )}[0]
end

mapping = possible_mapping.map { |rules| rules.shift }

puts mapping.zip(my_ticket).select { |rule, val| rule.start_with?("departure") }.map { |rule, val| val }.reduce(:*)
