# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::WeatherController do

  describe "GET api/v1/weather/current" do
    let(:request) { get :api_v1_weather_current }

    before

    it "returns response with current conditions" do
      expect(request).to eq
    end
  end
end