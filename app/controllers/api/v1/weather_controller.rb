# frozen_string_literal: true

class Api::V1::WeatherController < ApplicationController
  def current
    render json: AccuWeatherApi::Wrapper.current_conditions
  end

  def by_time
    nearest_condition = Weather::ByTimeSelector.new(
      conditions: AccuWeatherApi::Wrapper.day_conditions,
      select_timestamp: params[:timestamp]
    ).call

    if nearest_condition.present?
      render json: nearest_condition
    else
      render status: :not_found
    end
  end
end
