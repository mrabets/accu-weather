# frozen_string_literal: true

module Weather
  class ByTimeSelector
    def initialize(conditions:, select_timestamp:)
      @conditions = conditions
      @select_timestamp = select_timestamp.to_f
    end

    def call
      nearest_timestamp_condition
    end

    private

    attr_reader :conditions, :select_timestamp

    def nearest_timestamp_condition
      sorted_by_timestamp_conditions.detect { |condition| condition[:timestamp] >= select_timestamp }
    end

    def sorted_by_timestamp_conditions
      conditions.sort_by { |condition| condition[:timestamp] }
    end
  end
end
