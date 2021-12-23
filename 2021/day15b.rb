input = File.read("./day15.input").split("\n").map { |line| line.split("").map(&:to_i) }

wider_input = input.map do |line|
  new_line = line.dup
  4.times do |i|
    line.each do |point|
      new_value = point + i + 1
      new_line << (new_value > 9 ? new_value - 9 : new_value)
    end
  end
  new_line
end

input = []
5.times do |i|
  input += wider_input.map do |line|
    line.map do |point|
      new_value = point + i
      new_value > 9 ? new_value - 9 : new_value
    end
  end
end

puts input.last.inspect

Edge = Struct.new(:start, :end, :weight)
edges = []
vertices = []

input.each_with_index do |line, i|
  line.each_with_index do |point, j|
    if i.zero? and j.zero?
      vertices << [[0, 0], 0]
    else
      vertices << [[i, j], 1_000_000]
    end

    if i > 0
      edges << Edge.new([i - 1, j], [i, j], point)
    end

    if j > 0
      edges << Edge.new([i, j - 1], [i, j], point)
    end

    if i < input.length - 1
      edges << Edge.new([i + 1, j], [i, j], point)
    end

    if j < input.length - 1
      edges << Edge.new([i, j + 1], [i, j], point)
    end
  end
end

queue = vertices.dup
edge_map = edges.group_by { |edge| edge.start }
resolved = []

count = 0

# my initial implementation was pure array based, and very slow
# moved to use a hand-implemented priority queue
# and moved edges into a lookup hash rather than traversing the
# whole edge graph each time

while !queue.empty?
  print "." if queue.size % 100 == 0
  count += 1
  # elem = queue.min_by { |tup| tup[1] }
  elem = queue.shift
  # queue.delete(elem)
  resolved << elem
  # (a, b) = elem[0]
  adjacencies = edge_map[elem[0]]
  adjacencies.each do |edge|
    new_point = edge.end
    weight = edge.weight
    vert_idx = queue.find_index { |vert| vert[0] == new_point }
    next if vert_idx.nil?
    vert = queue[vert_idx]
    queue.delete_at(vert_idx)
    new_weight = [vert[1], elem[1] + weight].min
    new_node = [vert[0], new_weight]

    # queue << new_node
    index = queue.bsearch_index { |tup| new_weight <= tup[1] }
    if index.nil?
      queue.insert(0, new_node)
    else
      queue.insert(index, new_node)
    end
  end
end

puts edges.length
puts resolved.find { |vert| vert[0][0] == input.length - 1 && vert[0][1] == input.length - 1 }.inspect
