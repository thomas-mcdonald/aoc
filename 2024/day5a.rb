require "set"

input = File.read("day5.input").split("\n\n")
rules = input[0].split("\n").map { |line| line.split("|").map { |x| x.to_i } }
updates = input[1].split("\n").map { |line| line.split(",").map { |x| x.to_i } }

rules_map = {}
rules.each do |rule|
  rules_map[rule[0]] ||= []
  rules_map[rule[0]] << rule[1]
end

middle_numbers = updates.map do |update|
  visited_pages = Set.new()
  valid_update = update.all? do |page|
    valid_page_visit = (rules_map[page] || []).all? do |required_not_visit|
      !visited_pages.include?(required_not_visit)
    end
    next false unless valid_page_visit
    visited_pages << page
    true
  end
  next unless valid_update

  update[update.length / 2]
end.compact

puts middle_numbers.sum

print updates.inspect
