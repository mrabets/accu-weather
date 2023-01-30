class WeatherService < AccuWeatherAPI::Client
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
    last_day_temperature_list.max
  end

  def min_day_temperature
    last_day_temperature_list.min
  end

  def avg_day_temperature
    average_result = last_day_temperature_list.sum.to_f / last_day_temperature_list.size
    average_result.round(1)
  end

  private

  def last_day_temperature_list
    last_day_conditions_data.map(&method(:fetch_metric_temperature))
  end

  def fetch_metric_temperature(data)
    data.dig("Temperature", "Metric", "Value")
  end
end