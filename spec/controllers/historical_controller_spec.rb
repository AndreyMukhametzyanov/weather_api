# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HistoricalController, type: :request do
  subject(:stub_result) do
    [{ epoch_time: 1_666_294_080, temperature_in_c: 2.1 },
     { epoch_time: 1_666_294_085, temperature_in_c: 2.5 }]
  end

  describe '#historical' do
    before do
      Rails.cache.clear
      Rails.cache.write('historical', stub_result)
      get weather_historical_path
    end

    it 'return correct data' do
      expect(response).to have_http_status :ok
      expect(JSON.parse(response.body)['data']).to eq(JSON.parse(stub_result.to_json))
    end
  end

  describe '#max' do
    let(:result) { 'Maximum temperature is 2.5 C' }

    before do
      Rails.cache.clear
      Rails.cache.write('historical', stub_result)
      get weather_historical_max_path
    end

    it 'return correct data' do
      expect(response).to have_http_status :ok
      expect(JSON.parse(response.body)['max']).to eq(result)
    end
  end

  describe '#min' do
    let(:result) { 'Minimal temperature is 2.1 C' }

    before do
      Rails.cache.clear
      Rails.cache.write('historical', stub_result)
      get weather_historical_min_path
    end

    it 'return correct data' do
      expect(response).to have_http_status :ok
      expect(JSON.parse(response.body)['min']).to eq(result)
    end
  end

  describe '#avg' do
    let(:result) { 'Average temperature is 2.3 C' }

    before do
      Rails.cache.clear
      Rails.cache.write('historical', stub_result)
      get weather_historical_avg_path
    end

    it 'return correct data' do
      expect(response).to have_http_status :ok
      expect(JSON.parse(response.body)['avg']).to eq(result)
    end
  end
end
