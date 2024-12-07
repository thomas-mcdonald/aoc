input = File.read("day7.input").strip.split("\n").map { |xs| xs.split(": ") }

input = input.map do |line|
  target, steps = line
  steps = steps.split(" ").map(&:to_i)
  [target.to_i, steps]
end

matched_targets = []

input.each do |target, steps|
  input_values = Set.new
  steps.each do |step|
    if input_values.count ==  0
      input_values.add(step)
    else
      new_values = Set.new
      input_values.each do |value|
        new_values.add(value + step)
        new_values.add(value * step)
      end
      input_values = new_values
    end
  end
  if input_values.include?(target)
    matched_targets << target
  end
end

puts matched_targets.sum
