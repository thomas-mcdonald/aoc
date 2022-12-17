input = File.read("./day6.input").split("")

window = input.shift(14)
count = 14

while window.uniq != window
  window.shift
  window << input.shift
  count += 1
end

puts window.inspect
puts count
