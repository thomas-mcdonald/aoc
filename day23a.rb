input = File.read("./day23.input").strip.split("").map(&:to_i)

pc = 0
cups = input

count = 0
min_val = cups.min
max_val = cups.max

while count < 100
  current = cups[pc]

  puts "-- move #{count + 1} --"
  puts "current: #{current}"
  puts "cups: #{cups}"

  removal_index = pc + 1 < cups.size ? pc + 1 : 0
  c1 = cups.delete_at(removal_index)
  removal_index = pc + 1 < cups.size ? pc + 1 : 0
  c2 = cups.delete_at(removal_index)
  removal_index = pc + 1 < cups.size ? pc + 1 : 0
  c3 = cups.delete_at(removal_index)
  puts "pick up: #{c1} #{c2} #{c3}"

  target_value = current - 1
  until (target_idx = cups.index(target_value))
    if target_value > min_val
      target_value -= 1
    else
      target_value = max_val
    end
  end

  puts "destination: #{target_value}"
  cups.insert(target_idx + 1, c1)
  cups.insert(target_idx + 2, c2)
  cups.insert(target_idx + 3, c3)

  pc = (cups.index(current) + 1) % cups.size
  count += 1
end

puts "-- final -- "
puts "current: #{cups[pc]}"
puts cups.inspect
