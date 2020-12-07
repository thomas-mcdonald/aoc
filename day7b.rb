require "set"

input = File.read("./day7.input").split("\n")
ChildRule = Struct.new(:count, :bag)


map = {}
input.each do |rule|
  parent, raw_children = rule.split(" bags contain")
  children = raw_children.gsub(".", "").split(", ").map(&:strip)
  if children == ["no other bags"]
    map[parent] = []
  else
    map[parent] = children.map do |defn|
      parts = defn.split(" ")
      ChildRule.new(parts[0].to_i, parts[1..2].join(" "))
    end
  end
end

bags = ["shiny gold"]
count = -1
while !bags.empty?
  bag = bags.shift
  new_bags = map[bag].map { |rule| [rule.bag] * rule.count }.flatten
  bags += new_bags
  count += 1
end

puts count
