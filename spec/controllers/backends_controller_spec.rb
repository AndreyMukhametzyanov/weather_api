# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BackendsController, type: :request do
  describe '#weather' do
    let(:stub_historical) do
      [{ epoch_time: 1_666_294_080, temperature_in_c: 2.1 },
       { epoch_time: 1_666_294_085, temperature_in_c: 2.5 }]
    end
    let(:stub_current) { 'Current temperature for Moscow is 2.1 C' }
    let(:result) { 'Weather data was updated' }

    before do
      allow(City).to receive(:historical).and_return(stub_historical)
      allow(City).to receive(:current).and_return(stub_current)
      get weather_path
    end

    it 'return correct data' do
      expect(response).to have_http_status :ok
      expect(JSON.parse(response.body)['status']).to eq(result)
    end
  end

  describe '#health' do
    before { get health_path }

    it 'return status ok' do
      expect(response).to have_http_status :ok
    end
  end
end
