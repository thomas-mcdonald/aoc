input = File.read("day7.input").strip.split("\n").map { |xs| xs.split(": ") }

input = input.map do |line|
  target, steps = line
  steps = steps.split(" ").map(&:to_i)
  [target.to_i, steps]
end

matched_targets = Set.new

input.each do |target, steps|
  work = []
  first_step = steps.shift
  work << [first_step, steps]

  while !work.empty?
    current_step, remaining_steps = work.shift
    if remaining_steps.empty?
      if current_step == target
        matched_targets << target
      end
    else
      new_steps = remaining_steps.dup
      new_step = new_steps.shift
      work << [current_step + new_step, new_steps]
      work << [current_step * new_step, new_steps]
      work << [(current_step.to_s + new_step.to_s).to_i, new_steps]
    end
  end

  # steps.each do |step|
  #   if input_values.count ==  0
  #     input_values.add(step)
  #   else
  #     new_values = Set.new
  #     input_values.each do |value|
  #       new_values.add(value + step)
  #       new_values.add(value * step)
  #     end
  #     input_values = new_values
  #   end
  # end
  # if input_values.include?(target)
  #   matched_targets << target
  # end
end

puts matched_targets.sum
