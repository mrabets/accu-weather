require "test_helper"

class Api::V1::Weather::HistoricalControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_weather_historical_index_url
    assert_response :success
  end

  test "should get max" do
    get api_v1_weather_historical_max_url
    assert_response :success
  end

  test "should get min" do
    get api_v1_weather_historical_min_url
    assert_response :success
  end

  test "should get avg" do
    get api_v1_weather_historical_avg_url
    assert_response :success
  end
end
