input = File.open('weather.dat', File::RDONLY){|f| f.read}
input_array = input.lines.map(&:split)

input_array.slice!(0)
input_array.slice!(0)

spreads = []

input_array.each do |day|
  spread = [day[0].to_i, day[1].to_i - day[2].to_i]
  spreads << spread
end

spreads.sort_by! {|day| day[1]}
puts "The day with the least spread is #{spreads[0][0]}"