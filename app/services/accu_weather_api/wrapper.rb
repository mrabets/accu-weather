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
      attributes = transform_attributes(accu_weather_client.current_conditions[0])

      presented_data(attributes)
    end

    def day_conditions
      attributes = accu_weather_client.historical_conditions.map(&method(:transform_attributes))

      attributes.map(&method(:presented_data))
    end

    private

    attr_reader :accu_weather_client

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
