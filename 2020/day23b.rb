require "ruby-prof"
require "set"

input = File.read("./day23.input").strip.split("").map(&:to_i)

pc = 0
top_end = (10..1_000_000).to_a
cups = input + top_end

count = 0
min_val = cups.min
max_val = cups.max

class Node
  attr_accessor :value, :ptr

  def initialize(value, ptr)
    @value = value
    @ptr = ptr
  end

  def find(val)
    return self if value == val
    node = self.ptr
    until node.value == val
      node = node.ptr
    end
    node
  end

  def to_a
    result = [value]
    node = self.ptr
    until node == self
      result << node.value
      node = node.ptr
    end

    result
  end
end

nodes = cups.map { |val| Node.new(val, nil) }
nodes.each_cons(2).each { |a, b| a.ptr = b }
nodes[-1].ptr = nodes[0]

map = {}
nodes.each { |node| map[node.value] = node }

RubyProf.start

current = nodes[0]
while count < 10_000_000
  if count % 100_000 == 0
    print "#{count}.."
  end

  # puts "-- move #{count + 1} --"
  # puts "current: #{current.value}"
  # puts current.to_a.inspect
  # puts "cups: #{cups}"

  c1 = current.ptr
  c2 = c1.ptr
  c3 = c2.ptr
  current.ptr = c3.ptr
  removed_values = [c1, c2, c3].map(&:value)

  target_value = current.value - 1
  while removed_values.include?(target_value) || target_value.zero?
    if target_value > min_val
      target_value -= 1
    else
      target_value = max_val
    end
  end

  insertion = map[target_value]
  c3.ptr = insertion.ptr
  insertion.ptr = c1

  current = current.ptr
  count += 1
end

result = RubyProf.stop

# print a flat profile to text
printer = RubyProf::FlatPrinter.new(result)
printer.print(STDOUT)

puts "-- final -- "
cup_1 = current.find(1)
puts cup_1.ptr.value
puts cup_1.ptr.ptr.value
puts cup_1.ptr.value * cup_1.ptr.ptr.value
# puts cups.inspect
