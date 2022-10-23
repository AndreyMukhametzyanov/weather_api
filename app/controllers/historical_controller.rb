# frozen_string_literal: true

class HistoricalController < ApplicationController
  before_action :set_historical

  def historical
    render json: { data: @historical }
  end

  def max
    render json: { max: function(@historical, 'max') }
  end

  def min
    render json: { min: function(@historical, 'min') }
  end

  def avg
    render json: { avg: function(@historical, 'avg') }
  end

  private

  def set_historical
    @historical = Rails.cache.read('historical')
  end

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
end
