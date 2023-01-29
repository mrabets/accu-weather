require "test_helper"

class Api::V1::HealthControllerTest < ActionDispatch::IntegrationTest
  test "should get health" do
    get api_v1_health_health_url
    assert_response :success
  end
end
