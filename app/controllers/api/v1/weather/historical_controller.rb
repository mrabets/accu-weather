# frozen_string_literal: true

module Api
  module V1
    module Weather
      class HistoricalController < ApplicationController
        def index
          render json: day_conditions.as_json
        end

        def max
          render json: max_temperature_condition
        end

        def min
          render json: min_temperature_condition
        end

        def avg
          render json: avg_temperature_condition
        end

        private

        def max_temperature_condition
          day_conditions.max_by { |data| data[:temperature] }
        end

        def min_temperature_condition
          day_conditions.min_by { |data| data[:temperature] }
        end

        def avg_temperature_condition
          avg_value = ((max_temperature_condition[:temperature] + min_temperature_condition[:temperature]) / 2).round(1)

          { temperature: avg_value }
        end

        def day_conditions
          @day_conditions ||= AccuWeatherApi::DayConditionsWrapper.call
        end
      end
    end
  end
end
