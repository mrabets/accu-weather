# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccuWeatherApi::CurrentConditionWrapper do
  subject(:current_conditions) { described_class.call }

  let(:client) { instance_double(AccuWeatherApi::Client) }
  let(:response_result) do
    [
      {
        'EpochTime' => 123_456,
        'Temperature' => {
          'Metric' => {
            'Value' => -1.5
          }
        }
      }
    ]
  end

  before do
    allow(AccuWeatherApi::Client).to receive(:new).and_return(client)
    allow(client).to receive(:current_conditions).and_return(response_result)
  end

  it 'creates condition record', :aggregate_failures do
    expect { current_conditions }.to change(WeatherCondition, :count).by(1)
    expect(current_conditions.temperature).to eq(-1.5)
    expect(current_conditions.timestamp).to eq(123_456)
  end
end
