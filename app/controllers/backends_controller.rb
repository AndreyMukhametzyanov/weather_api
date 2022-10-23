# frozen_string_literal: true

class BackendsController < ApplicationController
  def health
    render json: { status: :ok }
  end

  def weather
    City.historical
    City.current
    render json: { status: 'Weather data was updated' }
  end
end
