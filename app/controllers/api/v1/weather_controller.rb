class Api::V1::WeatherController < ApplicationController
  def current
    render json: WeatherService.new.current_temperature
  end

  def by_time
  end
end
