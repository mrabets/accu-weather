require "test_helper"

class Api::V1::WeatherControllerTest < ActionDispatch::IntegrationTest
  test "should get current" do
    get api_v1_weather_current_url
    assert_response :success
  end

  test "should get by_time" do
    get api_v1_weather_by_time_url
    assert_response :success
  end
end
