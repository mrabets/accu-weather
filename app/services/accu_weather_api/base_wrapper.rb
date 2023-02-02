# frozen_string_literal: true

module AccuWeatherApi
  class BaseWrapper
    def self.call
      new.call
    end

    def initialize
      @accu_weather_client = Client.new
    end

    private

    attr_reader :accu_weather_client

    def transform_attributes(data)
      data.deep_transform_keys(&:underscore)
    end

    def fetch_metric_temperature(attributes)
      attributes.dig('temperature', 'metric', 'value')
    end
  end
end
