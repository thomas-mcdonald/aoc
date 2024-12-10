# ok, I was too clever with part 1

input = File.read("day9.input").strip.split("").map(&:to_i)

id = 0
tape = []
input.each_with_index do |size, idx|
  if idx % 2 == 0
    tape = tape.concat([id.to_s] * size)
    id += 1
  else
    tape = tape.concat(["."] * size)
  end
end


end_ptr = tape.length - 1
loop do
  if tape[end_ptr] == "."
    end_ptr -= 1
    next
  end
  if end_ptr < 0
    break
  end

  start_last_idx = tape.index(tape[end_ptr])
  slice = tape.slice(start_last_idx, end_ptr - start_last_idx + 1)
  start_idx = nil
  tape.each_with_index do |val, idx|
    break if idx >= start_last_idx
    if val == "." and start_idx == nil
      start_idx = idx
      if slice.length == 1
        tape[start_idx] = slice[0]
        tape[start_last_idx] = "."
        break
      end
    elsif start_idx != nil and val == "."
      gap_length = idx - start_idx + 1
      if gap_length >= slice.length
        tape[start_last_idx, slice.length] = ["."] * slice.length
        tape[start_idx, slice.length] = slice
        # end_ptr -= slice.length
        break
      end
    else
      start_idx = nil
    end
  end
  end_ptr -= slice.length
end

checksum = tape.each_with_index.map do |val, idx|
  if val == "."
    nil
  else
    val.to_i * idx
  end
end


# puts tape.join("").inspect
puts checksum.compact.sum
