input = File.read("./day14.input").split("\n").map { |ins| ins.split(" = ") }

mask = nil
mem = {}

input.each do |ins|
  if ins[0] == "mask"
    mask = ins[1]
  else
    index = ins[0][4..-2].to_i
    value = ins[1].to_i.to_s(2)
    padded_value = value.rjust(36, "0")
    new_value = padded_value.split("").each_with_index.map do |val, i|
      case mask[i]
      when "X"
        val
      else
        mask[i]
      end
    end.join("")

    mem[index] = new_value.to_i(2)
  end
end

puts mem.values.sum
