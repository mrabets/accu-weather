# frozen_string_literal: true

module Weather
  class ByTimeSelector
    def self.call(*args)
      new(*args).call
    end

    def initialize(select_timestamp)
      @select_timestamp = select_timestamp.to_f
    end

    def call
      return matched_condition if matched_condition.present?

      nearest_timestamp_condition
    end

    private

    attr_reader :select_timestamp

    def nearest_timestamp_condition
      WeatherCondition.where('timestamp >= ?', select_timestamp).order('timestamp ASC').limit(1)[0]
    end

    def matched_condition
      @matched_condition ||= WeatherCondition.find_by(timestamp: select_timestamp)
    end
  end
end
