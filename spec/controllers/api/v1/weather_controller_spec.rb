# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::WeatherController do
  describe 'GET api/v1/weather/current' do
    let(:request) { get :current }

    let(:weather_condition) { [build_stubbed(:weather_condition, temperature: 1, timestamp: 1)] }

    let(:expected_response_result) { [{ 'temperature' => 1.0, 'timestamp' => 1 }] }

    before { allow(AccuWeatherApi::CurrentConditionWrapper).to receive(:call).and_return(weather_condition) }

    it 'returns response with current conditions' do
      request

      expect(JSON.parse(response.body)).to eq(expected_response_result)
    end
  end
end
