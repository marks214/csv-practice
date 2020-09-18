require 'csv'
require 'awesome_print'

def get_all_olympic_athletes(filename)
  #test if the filename format is okay
  unless filename.class == String
    raise ArgumentError.new("invalid format, filename must be string")
  end

  # it is not efficient to store all the information first
  olympic_athlete_data = []
  CSV.read(filename, headers: true).each do |athlete_data|
    olympic_athlete_data << Hash[athlete_data]
  end

  len_of_data = olympic_athlete_data.length

  choices = []
  len_of_data.times do |index|
    choices << olympic_athlete_data[index].slice('ID', 'Name', 'Height', 'Team', 'Year', 'City', 'Sport', 'Event', 'Medal')
  end

  return choices

end

def total_medals_per_team(olympic_data)
  total_team_medals = {}
  medals = %w[Bronze Silver Gold]

  olympic_data.each do |athlete_data|
    if medals.include?(athlete_data['Medal'])
      country = athlete_data['Team']
      unless total_team_medals[country]
        total_team_medals[country] = 0
      end
      total_team_medals[country] += 1
    end
  end
  return total_team_medals
end

def get_all_gold_medalists(olympic_data)
  olympic_data.filter do |athlete_data|
    athlete_data['Medal'] == 'Gold'
  end


end
