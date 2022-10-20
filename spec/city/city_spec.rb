# frozen_string_literal: true

require 'rails_helper'

RSpec.describe City do
  describe '#current' do
    let(:city) { City::CITY_CODE }
    let(:key) { City::KEY }
    let(:body) do
      "[{\"LocalObservationDateTime\":\"2022-10-20T22:28:00+03:00\",
        \"EpochTime\":1666294080,
        \"WeatherText\":\"Cloudy\",
        \"Temperature\":{\"Metric\":{\"Value\":2.1,\"Unit\":\"C\",\"UnitType\":17},
        \"Imperial\":{\"Value\":36.0,\"Unit\":\"F\",\"UnitType\":18}}}]"
    end
    let(:result) { 'Current temperature for Moscow is 2.1 C' }

    before do
      stub_request(:get, "https://dataservice.accuweather.com/currentconditions/v1/#{city}?apikey=#{key}")
        .to_return(status: 200, body: body, headers: {})
    end

    it 'return correct answer' do
      expect(described_class.current).to eq(result)
    end
  end

  describe '#historical' do
    let(:city) { City::CITY_CODE }
    let(:key) { City::KEY }
    let(:body) do
      "[{\"LocalObservationDateTime\":\"2022-10-20T22:28:00+03:00\",
        \"EpochTime\":1666294080,
        \"WeatherText\":\"Cloudy\",
        \"Temperature\":{\"Metric\":{\"Value\":2.1,\"Unit\":\"C\",\"UnitType\":17},
        \"Imperial\":{\"Value\":36.0,\"Unit\":\"F\",\"UnitType\":18}}},
        {\"LocalObservationDateTime\":\"2022-10-20T22:28:00+03:00\",
        \"EpochTime\":1666294085,
        \"WeatherText\":\"Cloudy\",
        \"Temperature\":{\"Metric\":{\"Value\":2.5,\"Unit\":\"C\",\"UnitType\":17},
        \"Imperial\":{\"Value\":36.0,\"Unit\":\"F\",\"UnitType\":18}}}]"
    end
    let(:result) do
      [{ epoch_time: 1_666_294_080, temperature_in_c: 2.1 },
       { epoch_time: 1_666_294_085, temperature_in_c: 2.5 }]
    end

    before do
      stub_request(:get, "https://dataservice.accuweather.com/currentconditions/v1/#{city}/historical/24?apikey=#{key}")
        .to_return(status: 200, body: body, headers: {})
    end

    it 'return correct answer' do
      expect(described_class.historical).to eq(result)
    end
  end
end
