# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeathersController, type: :request do
  describe '#current' do
    let(:stub_result) { 'Current temperature for Moscow is 2.1 C' }

    before do
      Rails.cache.clear
      Rails.cache.write('current', stub_result)
      get weather_current_path
    end

    it 'return correct data' do
      expect(response).to have_http_status :ok
      expect(JSON.parse(response.body)['current']).to eq(Rails.cache.read('current'))
    end
  end

  describe '#by_time' do
    let(:stub_result) do
      [{ epoch_time: 1_666_294_080, temperature_in_c: 2.1 },
       { epoch_time: 1_666_294_085, temperature_in_c: 2.5 }]
    end

    context 'when timestamp is not number' do
      let(:timestamp) { 'example' }
      let(:msg) { 'not number' }

      before do
        Rails.cache.clear
        Rails.cache.write('historical', stub_result)
        get weather_by_time_path(timestamp: timestamp)
      end

      it 'return not number' do
        expect(response).to have_http_status :ok
        expect(JSON.parse(response.body)['timestamp']).to eq(msg)
      end
    end

    context 'when timestamp is not found' do
      let(:timestamp) { 1 }
      let(:msg) { 'not found' }

      before do
        Rails.cache.clear
        Rails.cache.write('historical', stub_result)
        get weather_by_time_path(timestamp: timestamp)
      end

      it 'return not found' do
        expect(response).to have_http_status :not_found
        expect(JSON.parse(response.body)['timestamp']).to eq(msg)
      end
    end

    context 'when timestamp is found' do
      let(:timestamp) { 1_666_294_082 }
      let(:msg) { 2.1 }

      before do
        Rails.cache.clear
        Rails.cache.write('historical', stub_result)
        get weather_by_time_path(timestamp: timestamp)
      end

      it 'return found' do
        expect(response).to have_http_status :ok
        expect(JSON.parse(response.body)['temperature by timestamp']).to eq(msg)
      end
    end
  end
end
