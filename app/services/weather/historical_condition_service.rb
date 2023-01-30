class Weather::HistoricalConditionService < Weather::ApiClient
  def day_temperature
    last_day_conditions_data.map do |hour_data|
      {
        time: hour_data["LocalObservationDateTime"],
        temperature: fetch_metric_temperature(hour_data)
      }
    end
  end

  def max_day_temperature
    last_day_temperature_list.max
  end

  def min_day_temperature
    last_day_temperature_list.min
  end

  def avg_day_temperature
    average_result = last_day_temperature_list.sum.to_f / last_day_temperature_list.size
    average_result.round(1)
  end

  def temperature_by_time(search_timestamp)
    search_timestamp = search_timestamp.to_f
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

  def last_day_temperature_list
   last_day_conditions_data.map(&method(:fetch_metric_temperature))
  end

  def fetch_metric_temperature(data)
    data.dig("Temperature", "Metric", "Value")
  end

  def last_day_conditions_data
    get("currentconditions/v1/#{location_key}/historical/24")
  end
end