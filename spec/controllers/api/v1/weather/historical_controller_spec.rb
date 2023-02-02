# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Weather::HistoricalController do
  let(:weather_conditions) do
    [
      build_stubbed(:weather_condition, temperature: 1, timestamp: 1),
      build_stubbed(:weather_condition, temperature: 2, timestamp: 2),
      build_stubbed(:weather_condition, temperature: 3, timestamp: 3)
    ]
  end

  before { allow(AccuWeatherApi::DayConditionsWrapper).to receive(:call).and_return(weather_conditions) }

  describe 'GET api/v1/weather' do
    let(:request) { get :index }

    let(:expected_response_result) do
      [
        { 'temperature' => 1.0, 'timestamp' => 1 },
        { 'temperature' => 2.0, 'timestamp' => 2 },
        { 'temperature' => 3.0, 'timestamp' => 3 }
      ]
    end

    it 'returns response with day conditions' do
      request

      expect(JSON.parse(response.body)).to eq(expected_response_result)
    end
  end

  describe 'GET api/v1/weather/max' do
    let(:request) { get :max }

    let(:expected_response_result) { { 'temperature' => 3.0, 'timestamp' => 3 } }

    it 'returns response with day conditions' do
      request

      expect(JSON.parse(response.body)).to eq(expected_response_result)
    end
  end

  describe 'GET api/v1/weather/min' do
    let(:request) { get :min }

    let(:expected_response_result) { { 'temperature' => 1.0, 'timestamp' => 1 } }

    it 'returns response with day conditions' do
      request

      expect(JSON.parse(response.body)).to eq(expected_response_result)
    end
  end

  describe 'GET api/v1/weather/avg' do
    let(:request) { get :avg }

    let(:expected_response_result) { { 'temperature' => 2.0 } }

    it 'returns response with day conditions' do
      request

      expect(JSON.parse(response.body)).to eq(expected_response_result)
    end
  end
end
