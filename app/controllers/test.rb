require 'net/http'
require 'uri'
require 'rexml/document'
require 'json'

CITY_CODE = 294_021

class CityTemperatureService

  def initialize(city_code)
    @city_code = city_code
  end

  URL = 'https://dataservice.accuweather.com'

  # KEY = 'W4N1RHYjQihr5CMPWjYJIYImaxKySneA'
  KEY = 'UEev5arAPitrH55AXH14vpH4lmeyYXpx'

  #done
  def current_conditions
    url = "https://dataservice.accuweather.com/currentconditions/v1/#{@city_code}?apikey=#{KEY}"
    weather_uri = URI.parse(url)
    response = Net::HTTP.get_response(weather_uri)
    result = JSON.parse(response.body)
    "Current temperature is #{ result.first['Temperature']['Metric']['Value']} C"
  end

  # done
  def historical
    url = "https://dataservice.accuweather.com/currentconditions/v1/#{@city_code}/historical/24?apikey=#{KEY}"
    weather_uri = URI.parse(url)
    response = Net::HTTP.get_response(weather_uri)
    result = JSON.parse(response.body)
    result.map do |elem|
      {
        epoch_time: elem['EpochTime'],
        temperature_in_c: elem['Temperature']['Metric']['Value']
      }
    end
  end

  #done
  def function(massive, function_name)
    temperatures = []
    massive.each do |el|
      temperatures << el[:temperature_in_c]
    end

    case function_name
    when 'max'
      "Maximum temperature is #{temperatures.max} C"
    when 'min'
      "Minimal temperature is #{temperatures.min} C"
    when 'avg'
      "Average temperature is #{(temperatures.sum / temperatures.count).round(1)} C"
    else
      raise StandardError
    end
  end

  #done
  def by_time(timestamp, massive)
    epoch_time = []
    massive.each do |el|
      epoch_time << el[:epoch_time]
    end

    dif = epoch_time.map { |elem| (timestamp - elem).abs }
    result = epoch_time[dif.index(dif.min)] #минимальная разница это и есть самый близкий вариант
    Time.at(result)
  end

  # def self.get_city_params(city_code)
  #   url = "#{URL}/locations/v1/#{city_code}?apikey=#{KEY}"
  #   weather_uri = URI.parse(url)
  #   response = Net::HTTP.get_response(weather_uri)
  #   result = JSON.parse(response.body)
  #   "#{result['Temperature']['Metric']['Value']} #{result['Temperature']['Metric']['Unit']}"
  # end
end

a = CityTemperatureService.new(CITY_CODE)
cur = a.current_conditions
historical = a.historical
puts cur

# timestamp = 1621823790
# massive = [{ epoch_time: 10, temperature_in_c: 8.9 },
#      { epoch_time: 25, temperature_in_c: 8.6 },
#      { epoch_time: 17, temperature_in_c: 8.0 },
#      { epoch_time: 1, temperature_in_c: 6.9 },
#      { epoch_time: 6, temperature_in_c: 6.9 },
#      { epoch_time: 7, temperature_in_c: 3.2 },
#      { epoch_time: 8, temperature_in_c: 3.6 }
# ]
