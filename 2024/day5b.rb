require "set"

input = File.read("day5.input").split("\n\n")
rules = input[0].split("\n").map { |line| line.split("|").map { |x| x.to_i } }
updates = input[1].split("\n").map { |line| line.split(",").map { |x| x.to_i } }

rules_map = {}
rules.each do |rule|
  rules_map[rule[0]] ||= []
  rules_map[rule[0]] << rule[1]
end

def valid_update?(update, rules_map)
  visited_pages = Set.new()
  return update.all? do |page|
    valid_page_visit = (rules_map[page] || []).all? do |required_not_visit|
      !visited_pages.include?(required_not_visit)
    end
    next false unless valid_page_visit
    visited_pages << page
    true
  end
end

incorrect_updates = updates.select do |update|
  !valid_update?(update, rules_map)
end.compact

middle_elements = incorrect_updates.map do |update|
  # oof
  rules_for_update = update.map { |page| [page, rules_map[page].intersection(update)] }.to_h
  ordered = rules_for_update.sort_by { |k, v| v.length }.to_h.keys
  ordered[ordered.length / 2]
end

puts middle_elements.sum


# puts incorrect_updates.inspect
