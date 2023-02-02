# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccuWeatherApi::Wrapper do
  let(:client) { instance_double(AccuWeatherApi::Client) }

  before { allow(AccuWeatherApi::Client).to receive(:new).and_return(client) }

  describe '.current_conditions' do
    let(:current_conditions) { described_class.new.current_conditions }

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

    before { allow(client).to receive(:current_conditions).and_return(response_result) }

    it 'creates condition record', :aggregate_failures do
      expect { current_conditions }.to change(WeatherCondition, :count).by(1)
      expect(current_conditions.temperature).to eq(-1.5)
      expect(current_conditions.timestamp).to eq(123_456)
    end
  end

  describe '.day_conditions' do
    let(:day_conditions) { described_class.new.day_conditions }

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

    before { allow(client).to receive(:historical_conditions).and_return(response_result) }

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
end
