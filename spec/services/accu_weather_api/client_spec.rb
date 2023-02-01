# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccuWeatherApi::Client do
  subject(:client) { described_class.new }

  shared_examples 'day condition' do
    it 'returns day weather condition', :aggregate_failures do
      expect(response).to be_kind_of(Array)
      expect(response[0]).to be_kind_of(Hash)
      expect(response[0].dig('Temperature', 'Metric', 'Value')).to be_kind_of(Float)
    end
  end

  describe '#current_conditions' do
    let(:response) do
      VCR.use_cassette('weather/current_conditions') do
        client.current_conditions
      end
    end

    it_behaves_like 'day condition'
  end

  describe '#historical_conditions' do
    let(:response) do
      VCR.use_cassette('weather/historical_conditions') do
        client.historical_conditions
      end
    end

    it_behaves_like 'day condition'

    it 'returns 24 weather conditions' do
      expect(response.size).to eq(24)
    end
  end
end
