require "set"

input = File.read("./day21.input").split("\n").map do |line|
  ingredients, allergens = line.split(" (contains ")
  ingredients = ingredients.split(" ")
  allergens = allergens.sub(")", "").split(", ")
  [Set.new(ingredients), Set.new(allergens)]
end

ingredient_list = input.map { |row| row[0] }.reduce(&:union)
allergen_list = input.map { |row| row[1] }.reduce(&:union)
allergen_mapping = {}

# broad idea: intersect lists with each other to create new rules
# iA n iB => aA n aB
def generate_rule(a, b)
  ingredients = a[0].intersection(b[0])
  allergens = a[1].intersection(b[1])
  if ingredients.empty? or allergens.empty?
    nil
  else
    [ingredients, allergens]
  end
end

rules = input
while allergen_mapping.length != allergen_list.length
  puts rules.length
  new_rules = rules.combination(2).map { |a, b| generate_rule(a, b) }.compact
  puts "new: #{new_rules.length}"
  rules = (rules + new_rules).uniq

  resolutions = rules.select { |igs, ags| igs.length == 1 and ags.length == 1 }
  resolutions.each { |igs, ags| allergen_mapping[igs.to_a.pop] = ags.to_a.pop }

  rules = rules.map do |ingredients, allergens|
    [ingredients - allergen_mapping.keys, allergens - allergen_mapping.values]
  end

  puts allergen_mapping
end

not_allergen = ingredient_list - allergen_mapping.keys
puts input.map { |row| row[0].intersection(not_allergen).length }.sum
