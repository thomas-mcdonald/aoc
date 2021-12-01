input = "19,20,14,0,9,1".split(",").map(&:to_i)

turn = 0
most_recent = nil
last_heard = {}

input.each do |number|
  turn += 1
  last_heard[number] = [turn]
end

number = 0

while turn < 30000000
  turn += 1
  last_heard[number] ||= []
  last_heard[number] << turn


  puts [turn, number].join(" , ").inspect if 30000000 - turn < 100

  if last_heard[number].nil? or last_heard[number].length < 2
    number = 0
  else
    number = last_heard[number][-1] - last_heard[number][-2]
  end

end
