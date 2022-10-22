# frozen_string_literal: true

class WeathersController < ApplicationController
  before_action :set_current

  def current
    render json: { current: @current }
  end

  def by_time
    weather_by_timestamp = weather_by_timestamp(params[:timestamp], Rails.cache.read('historical'))
    if weather_by_timestamp.empty?
      render json: { timestamp: 'not found' }, status: :not_found
    else
      render json: weather_by_timestamp
    end
  end

  private

  def set_current
    @current = Rails.cache.read('current')
  end

  def weather_by_timestamp(timestamp, massive)
    if timestamp.match('^[0-9]+$')
      epoch_time = []

      massive.each do |el|
        epoch_time << el[:epoch_time]
      end
      m = epoch_time.sort
      if (m.first..m.last).include?(timestamp.to_i)
        dif = epoch_time.map { |elem| (timestamp.to_i - elem).abs }
        result = epoch_time[dif.index(dif.min)] # минимальная разница это и есть самый близкий вариант

        { 'temperature by timestamp': find_temperature(result, massive) }
      else
        {}
      end
    else
      { timestamp: 'not number' }
    end
  end

  def find_temperature(timestamp, massive)
    res = 0
    massive.each do |elem|
      res += elem[:temperature_in_c] if elem[:epoch_time] == timestamp
    end
    res
  end
end
