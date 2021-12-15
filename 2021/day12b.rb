require "set"

input = File.read("./day12.input").split("\n").map { |line| line.split("-") }

travel_pairs = input.map do |rule|
  if rule[0] == "start" || rule[1] == "end"
    [rule]
  elsif rule[1] == "start" || rule[0] == "end"
    [[rule[1], rule[0]]]
  else
    [rule, [rule[1], rule[0]]]
  end
end.flatten(1)

allowed_travel = travel_pairs.reduce(Hash.new { |h, k| h[k] = [] }) do |acc, x|
  acc[x[0]] << x[1]
  acc
end

paths = Set.new
queue = [["start"]]

while !queue.empty?
  path_to_expand = queue.pop
  potential_additions = allowed_travel[path_to_expand.last]
  potential_additions.each do |loc|
    new_path = path_to_expand.dup + [loc]
    dups = new_path.select { |elem| elem.downcase == elem }.tally

    # lol, write only code
    next if dups.values.any? { |count| count > 2 }
    next if dups.select { |k, v| v > 1 }.count > 1

    if new_path.last != "end"
      queue.push(new_path)
    else
      paths << new_path
    end
  end
end

puts paths.count
