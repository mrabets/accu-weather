class Api::V1::Weather::HistoricalController < ApplicationController
  def index
    render json: WeatherService.new.day_temperature
  end

  def max
    render json: WeatherService.new.max_day_temperature
  end

  def min
    render json: WeatherService.new.min_day_temperature
  end

  def avg
    render json: WeatherService.new.avg_day_temperature
  end
end
