input = File.read("./day16.input")

Packet = Struct.new(:data, :version, :type) do
  def value
    case type
    when 0
      data.map(&:value).sum
    when 1
      data.map(&:value).reduce(1, &:*)
    when 2
      data.map(&:value).min
    when 3
      data.map(&:value).max
    when 4
      data.first
    when 5
      data[0].value > data[1].value ? 1 : 0
    when 6
      data[0].value < data[1].value ? 1 : 0
    when 7
      data[0].value == data[1].value ? 1 : 0
    end
  end
end

def parse(str)
  version = str.shift(3).join.to_i(2)
  type_id = str.shift(3).join.to_i(2)
  case type_id
  when 4
    bits = []
    while str.shift == "1"
      bits << str.shift(4)
    end
    bits << str.shift(4)
    value = bits.join.to_i(2)
    [Packet.new([value], version, type_id), str]
  else
    length_type_id = str.shift.to_i
    case length_type_id
    when 0
      bit_length = str.shift(15).join.to_i(2)
      sub_packet = str.shift(bit_length)
      packets = []
      while !sub_packet.empty?
        (parsed_value, sub_packet) = parse(sub_packet)
        packets << parsed_value
      end
      [Packet.new(packets, version, type_id), str]
    when 1
      packet_count = str.shift(11).join.to_i(2)
      packets = []
      sub_packet = str
      while packet_count > 0
        (parsed_value, sub_packet) = parse(str)
        packet_count -= 1
        packets << parsed_value
      end
      [Packet.new(packets, version, type_id), str]
    end
  end
end

binary = input.strip.chars.map{ |ch| ch.hex.to_s(2).rjust(4, "0").chars }.flatten
packet = parse(binary)

puts packet.first.value
