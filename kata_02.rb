input = File.open('football.dat', File::RDONLY){|f| f.read}
input_array = input.lines.map(&:split)
input_array.slice!(0)

score_diffs = []

input_array.each do |team|
  unless team[7] == nil
    score_diff = (team[7].to_i - team[9].to_i).abs
    input_hash = {team: team[1], score_diff: score_diff}
    score_diffs << input_hash
  end
end

score_diffs.sort_by! {|team_info| team_info[:score_diff]}

puts "The team with the lowest score difference is #{score_diffs[0][:team]} with a difference of #{score_diffs[0][:score_diff]} points"