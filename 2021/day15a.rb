input = File.read("./day15.input").split("\n").map { |line| line.split("").map(&:to_i) }

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
  end
end

queue = vertices.dup
resolved = []

count = 0
puts queue.size

while !queue.empty?
  print "." if queue.size % 100 == 0
  count += 1
  elem = queue.min_by { |tup| tup[1] }
  queue.delete(elem)
  resolved << elem
  (a, b) = elem[0]
  adjacencies = edges.select { |edge| edge.start[0] == a && edge.start[1] == b }
  adjacencies.each do |edge|
    new_point = edge.end
    weight = edge.weight
    vert = queue.find { |vert| vert[0] == new_point }
    next if vert.nil?
    queue.delete(vert)
    new_weight = [vert[1], elem[1] + weight].min
    new_node = [vert[0], new_weight]
    queue << new_node
  end
end

puts edges.length
puts resolved.find { |vert| vert[0][0] == input.length - 1 && vert[0][1] == input.length - 1 }.inspect
