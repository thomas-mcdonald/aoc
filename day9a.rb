input = File.read("./day9.input").split("\n").map(&:to_i)

window_size = 25

(input.length - window_size).times do |i|
  number = input[i + window_size]
  source_numbers = input[i..(i + window_size - 1)]
  valid_candidates = source_numbers.combination(2).map { |a, b| a + b }
  if valid_candidates.include?(number)
    print "."
  else
    puts ""
    puts number
    break
  end
end
