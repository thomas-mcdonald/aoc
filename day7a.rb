require "set"

input = File.read("./day7.input").split("\n")

map = {}
input.each do |rule|
  parent, raw_children = rule.split(" bags contain")
  children = raw_children.gsub(".", "").split(", ").map(&:strip)
  if children == ["no other bags"]
    map[parent] = []
  else
    map[parent] = children.map { |defn| defn.split(" ")[1..2].join(" ") }
  end
end

bags = ["shiny gold"]
total = Set.new
while !bags.empty?
  bag = bags.shift
  valid_containers = map.select { |k, v| v.include?(bag) }.to_h.keys
  bags += valid_containers
  total += valid_containers
end

puts total.size
