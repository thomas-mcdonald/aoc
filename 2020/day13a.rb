input = File.read("./day13.input").split("\n")

timestamp = input[0].to_i
ints = input[1].split(",").reject { |x| x == "x" }.map(&:to_i)

first_departure = [0, 9999999999999999999]
departures = ints.map do |i|
  after_timestamp = ((timestamp / i) + 1) * i
  first_departure = [i, after_timestamp] if after_timestamp < first_departure[1]
end

puts first_departure.inspect
puts (first_departure[1] - timestamp) * first_departure[0]
