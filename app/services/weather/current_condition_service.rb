class Weather::CurrentConditionService < Weather::ApiClient
  def call
    fetch_metric_temperature(current_conditions_data.first)
  end

  private

  def fetch_metric_temperature(data)
    data.dig("Temperature", "Metric", "Value")
  end

end