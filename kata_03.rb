class DatInterpretor
  attr_reader :data, :data_file

  def initialize
    @data = []
    @data_file = ""
  end

  def main
    type_pick
    data_import
    analysis
  end

  private

  def type_pick
    puts "Do you want to analyze football or weather data? (football/weather)"
    response = gets.chomp
    continue = false
    while (continue == false)
      if (response == "football")
        @data_file = "football.dat"
        continue = true
      elsif (response == "weather")
        @data_file = "weather.dat"
        continue = true
      else
        puts "there was typo, answer again: weather or football?"
      end
    end
    puts "Thank you. Proceeding with analysis"
  end

  def data_import
    if (@data_file)
      if (@data_file == "football.dat")
        input = File.open('football.dat', File::RDONLY){|f| f.read}
      else (@data_file == "weather.dat")
        input = File.open('weather.dat', File::RDONLY){|f| f.read}
      end
      input_array = input.lines.map(&:split)
      if (@data_file == "football.dat")
        football_data(input_array)
      else (@data_file == "weather.dat")
        weather_data(input_array)
      end
      return @data
    end
  end

  def football_data(array)
    array.slice!(0)
    @data = array
  end

  def weather_data(array)
    array.slice!(0)
    array.slice!(0)
    @data = array
  end

  def analysis
    identifier = nil
    higher = nil
    lower = nil
    if (@data_file == "football.dat")
      identifier = 1
      higher = 7
      lower = 9
    elsif (@data_file == "weather.dat")
      identifier = 0
      higher = 1
      lower = 2
    end
    puts "identifier: #{identifier}, higher: #{higher}, lower: #{lower}"
    spreads = []

    @data.each do |row|
      if (row[higher])
        spread = (row[higher].to_i - row[lower].to_i).abs
        input_hash = {identifier: row[identifier], spread: spread}
        spreads << input_hash
      end
    end

    spreads.sort_by! {|row| row[:spread]}
    puts "The one with the lowest spread is #{spreads[0][:identifier]}. The spread is #{spreads[0][:spread]}"
  end
end

runner = DatInterpretor.new

runner.main