input = File.read("./day7.input").split("\n")

current_location = []
files = []

while input.length > 0
  command = input.shift.split(" ")
  if command[0] == "$"
    case command[1]
    when "cd"
      if command[2] == "/"
        current_location = []
      elsif command[2] == ".."
        current_location.pop
      else
        current_location << command[2]
      end
    when "ls"
      next
    end
  elsif command[0].to_i.to_s == command[0]
    location = (current_location.dup) << command[1]
    files <<  [location, command[0]]
  end
end

folder_sizes = Hash.new { |h, k| h[k] = 0 }

files.each do |file|
  path_parts, size = file
  path_pieces = path_parts.dup
  path_pieces.pop
  processed_path = []
  path_pieces.each do |part|
    processed_path << part
    path = "/" + processed_path.join("/")
    folder_sizes[path] += size.to_i
  end
end

puts folder_sizes.values.filter { |size| size <= 100000 }.sum
