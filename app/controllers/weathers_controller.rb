class WeathersController < ApplicationController
  before_action :set_current

  def current
    render json: { current: @current }
  end

  #не до конца работает подправить время и должен вернуть температуру в это время
  def by_time
    weather_by_timestamp = weather_by_timestamp(params[:timestamp], Rails.cache.read('historical'))
    if weather_by_timestamp.nil?
      render json: { status: 'not_found' }, status: :not_found
    else
      render json: { "temperature by timestamp = #{params[:timestamp]} is": weather_by_timestamp }
    end

  end

  private

  def set_current
    @current = Rails.cache.read('current')
  end

  def weather_by_timestamp(timestamp, massive)
    if timestamp.match("^[0-9]+$")
      epoch_time = []

      massive.each do |el|
        epoch_time << el[:epoch_time]
      end

      dif = epoch_time.map { |elem| (timestamp.to_i - elem).abs }
      result = epoch_time[dif.index(dif.min)] #минимальная разница это и есть самый близкий вариант

      find_temperature(result, massive)
    else
      'timestamp is not number'
    end
  end

  def find_temperature(timestamp, massive)
    res = 0
    massive.each do |elem|
      if elem[:epoch_time] == timestamp
        res += elem[:temperature_in_c]
      end
    end
    res
  end
end
