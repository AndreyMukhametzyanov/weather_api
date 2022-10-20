# frozen_string_literal: true

Rails.application.routes.draw do
  get '/weather/current', to: 'weathers#current'
  get '/weather/by_time/:timestamp', to: 'weathers#by_time'
  get '/weather/historical', to: 'historical#historical'
  get '/weather/historical/max', to: 'historical#max'
  get '/weather/historical/min', to: 'historical#min'
  get '/weather/historical/avg', to: 'historical#avg'
  get '/health', to: 'backends#health'
  get '/weather', to: 'backends#weather'
end
