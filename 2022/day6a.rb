input = File.read("./day6.input").split("")

window = input.shift(4)
count = 4

while window.uniq != window
  window.shift
  window << input.shift
  count += 1
end

puts window.inspect
puts count
