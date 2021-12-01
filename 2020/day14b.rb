input = File.read("./day14.input").split("\n").map { |ins| ins.split(" = ") }

mask = nil
mem = {}

input.each do |ins|
  if ins[0] == "mask"
    mask = ins[1]
  else
    value = ins[1].to_i

    index = ins[0][4..-2].to_i
    padded_index = index.to_s(2).rjust(36, "0")
    locations = [""]
    padded_index.split("").each_with_index do |val, i|
      case mask[i]
      when "0"
        locations = locations.map { |loc| loc << val }
      when "1"
        locations = locations.map { |loc| loc << "1" }
      when "X"
        locations = locations.map { |loc| [loc + "0", loc + "1"] }.flatten
      end
    end

    locations.each do |bit_index|
      index = bit_index.to_i(2)
      mem[index] = value
    end
  end
end

puts mem.values.sum
