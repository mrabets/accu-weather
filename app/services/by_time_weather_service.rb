class ByTimeWeatherService < WeatherService
  attr_reader :search_timestamp

  def initialize(search_timestamp)
    @search_timestamp = search_timestamp.to_f
  end

  def call
    nearest_timestamp = timestamp_temperatures.keys.bsearch { |timestamp| timestamp >= search_timestamp }
    timestamp_temperatures[nearest_timestamp]
  end

  private

  def timestamp_temperatures
    result = last_day_conditions_data.each_with_object({}) do |hour_data, timestamp_temperature|
      timestamp_temperature[hour_data["EpochTime"]] = fetch_metric_temperature(hour_data)
    end

    result.sort.to_h
  end
end