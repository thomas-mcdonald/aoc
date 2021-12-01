input = File.read("./day13.input").split("\n")

constraints = input[1].split(",").each_with_index.map do |val, index|
  [val, index]
end.reject { |val, idx| val == "x" }.map { |val, idx| [val.to_i, idx] }

puts constraints.inspect

t = 0
synced = [constraints[0]]
step = constraints[0][0]
puts step

valid = false
while !valid do
  valid = true
  t += step
  constraints.each do |constraint|
    if (t + constraint[1]) % constraint[0] == 0
      synced << constraint
      step = synced.map { |c| c[0] }.reduce(:lcm)
      puts "location: #{t}"
      puts "step: #{step}"
    else
      valid = false
      break
    end
  end
end
