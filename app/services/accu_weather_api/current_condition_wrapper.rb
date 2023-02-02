# frozen_string_literal: true

module AccuWeatherApi
  class CurrentConditionWrapper < BaseWrapper
    def call
      condition_attributes = transform_attributes(accu_weather_client.current_conditions[0])

      weather_condition(condition_attributes)
    end

    private

    attr_reader :accu_weather_client

    def weather_condition(attributes)
      WeatherCondition.where(timestamp: attributes['epoch_time'])
                      .first_or_create { |condition| condition.temperature = fetch_metric_temperature(attributes) }
    end
  end
end
