# frozen_string_literal: true

module AccuWeatherApi
  class Wrapper
    include Singleton

    class << self
      delegate :current_conditions, to: :instance
      delegate :day_conditions, to: :instance
    end

    def initialize
      @accu_weather_client = Client.new
    end

    def current_conditions
      condition_attributes = transform_attributes(accu_weather_client.current_conditions[0])

      weather_condition(condition_attributes)
    end

    def day_conditions
      conditions_attribute_list = accu_weather_client.historical_conditions.map(&method(:transform_attributes))

      weather_conditions(conditions_attribute_list)
    end

    private

    attr_reader :accu_weather_client

    def weather_conditions(attribute_list)
      attribute_list.map(&method(:weather_condition))
    end

    def weather_condition(attributes)
      Rails.cache.fetch(attributes['epoch_time'], expires: 30.minutes) do
        WeatherCondition.where(timestamp: attributes['epoch_time'])
                        .first_or_create { |condition| condition.temperature = fetch_metric_temperature(attributes) }
      end
    end

    def presented_data(attributes)
      {
        temperature: fetch_metric_temperature(attributes),
        timestamp: attributes['epoch_time']
      }
    end

    def transform_attributes(data)
      data.deep_transform_keys(&:underscore)
    end

    def fetch_metric_temperature(attributes)
      attributes.dig('temperature', 'metric', 'value')
    end
  end
end
