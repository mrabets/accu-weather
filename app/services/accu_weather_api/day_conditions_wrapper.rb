# frozen_string_literal: true

module AccuWeatherApi
  class DayConditionsWrapper < BaseWrapper
    def call
      conditions_attribute_list = accu_weather_client.historical_conditions.map(&method(:transform_attributes))

      weather_conditions(conditions_attribute_list)
    end

    private

    attr_reader :accu_weather_client

    def weather_conditions(attribute_list)
      Rails.cache.fetch('day_conditions', expires: 30.minutes) do
        attribute_list.map(&method(:weather_condition))
      end
    end

    def weather_condition(attributes)
        WeatherCondition.where(timestamp: attributes['epoch_time'])
                        .first_or_create { |condition| condition.temperature = fetch_metric_temperature(attributes) }
    end
  end
end
