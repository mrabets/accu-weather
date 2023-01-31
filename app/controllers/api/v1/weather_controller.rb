# frozen_string_literal: true

class Api::V1::WeatherController < ApplicationController
  def current
    render json: AccuWeatherApi::Wrapper.current_conditions.as_json
  end

  def by_time
    condition = Weather::ByTimeSelector.new(params[:timestamp]).call

    if condition.present?
      render json: condition
    else
      render status: :not_found
    end
  end
end
