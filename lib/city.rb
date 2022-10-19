require 'net/http'
require 'uri'
require 'rexml/document'
require 'json'

class City

  CITY_CODE = 294_021
  URL = 'https://dataservice.accuweather.com'
  KEY = 'W4N1RHYjQihr5CMPWjYJIYImaxKySneA'
  # KEY = 'UEev5arAPitrH55AXH14vpH4lmeyYXpx'

  def self.current
    url = "https://dataservice.accuweather.com/currentconditions/v1/#{CITY_CODE}?apikey=#{KEY}"
    weather_uri = URI.parse(url)
    response = Net::HTTP.get_response(weather_uri)
    result = JSON.parse(response.body)
    line = "Current temperature for Moscow is #{ result.first['Temperature']['Metric']['Value']} C"
    Rails.cache.write("current", line)
    line
  end

  def self.historical
    url = "https://dataservice.accuweather.com/currentconditions/v1/#{CITY_CODE}/historical/24?apikey=#{KEY}"
    weather_uri = URI.parse(url)
    response = Net::HTTP.get_response(weather_uri)
    massive = JSON.parse(response.body)
    result = massive.map do |elem|
      {
        epoch_time: elem['EpochTime'],
        temperature_in_c: elem['Temperature']['Metric']['Value']
      }
    end
    Rails.cache.write("historical", result)
    result
  end
end
