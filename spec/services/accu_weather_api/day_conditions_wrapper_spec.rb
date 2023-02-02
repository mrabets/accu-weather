# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccuWeatherApi::DayConditionsWrapper do
  subject(:day_conditions) { described_class.call }

  let(:client) { instance_double(AccuWeatherApi::Client) }
  let(:response_result) do
    [
      {
        'EpochTime' => 123_456,
        'Temperature' => {
          'Metric' => {
            'Value' => 2.2
          }
        }
      },
      {
        'EpochTime' => 123_457,
        'Temperature' => {
          'Metric' => {
            'Value' => -3.5
          }
        }
      },
      {
        'EpochTime' => 123_458,
        'Temperature' => {
          'Metric' => {
            'Value' => -1.8
          }
        }
      }
    ]
  end

  before do
    allow(AccuWeatherApi::Client).to receive(:new).and_return(client)
    allow(client).to receive(:historical_conditions).and_return(response_result)
  end

  it 'creates condition records', :aggregate_failures do
    expect { day_conditions }.to change(WeatherCondition, :count).by(3)

    expect(day_conditions[0].temperature).to eq(2.2)
    expect(day_conditions[0].timestamp).to eq(123_456)
    expect(day_conditions[1].temperature).to eq(-3.5)
    expect(day_conditions[1].timestamp).to eq(123_457)
    expect(day_conditions[2].temperature).to eq(-1.8)
    expect(day_conditions[2].timestamp).to eq(123_458)
  end
end
