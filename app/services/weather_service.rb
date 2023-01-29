class WeatherService < ApiClient
  def current_temperature
    fetch_metric_temperature(current_conditions_data.first)
  end

  def day_temperature
    last_day_conditions_data.map do |hour_data|
      {
        time: hour_data["LocalObservationDateTime"],
        temperature: fetch_metric_temperature(hour_data)
      }
    end
  end

  def max_day_temperature
    temperature_list.max
  end

  def min_day_temperature
    temperature_list.min
  end

  def avg_day_temperature
    # temperature_list.sum.to_f / temperature_list.size
  end

  private

  def temperature_list
   last_day_conditions_data.map(&method(:fetch_metric_temperature))
  end

  def fetch_metric_temperature(data)
    data.dig("Temperature", "Metric", "Value")
  end

  def current_conditions_data
    get("currentconditions/v1/#{location_key}")
  end

  def last_day_conditions_data
    get("currentconditions/v1/#{location_key}/historical/24")
  end
end