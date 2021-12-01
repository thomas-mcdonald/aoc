input = File.read("./day5.input").split("\n")

def resolve_seat(rows, seats, string)
  return rows, seats if string.empty?

  char = string.shift

  case char
  when "F"
    lower = rows.min
    upper = (rows.max - rows.min) / 2 + rows.min
    resolve_seat(lower..upper, seats, string)
  when "B"
    lower = rows.size / 2 + rows.min
    upper = rows.max
    resolve_seat(lower..upper, seats, string)
  when "L"
    lower = seats.min
    upper = (seats.max - seats.min) / 2 + seats.min
    resolve_seat(rows, lower..upper, string)
  when "R"
    lower = seats.size / 2 + seats.min
    upper = seats.max
    resolve_seat(rows, lower..upper, string)
  else
    puts "unhandled code #{char}"
  end
end

seats = input.map do |bp|
  row, seat = resolve_seat((0..127), (0..7), bp.split(""))
  row.min * 8 + seat.min
end

# discovered with puts seats.sort.inspect
puts (59..904).to_a - seats
