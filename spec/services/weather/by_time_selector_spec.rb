# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Weather::ByTimeSelector do
  subject(:selector) { described_class.call(select_timestamp) }

  let!(:matched_weather_condition) { create(:weather_condition, timestamp: 150_000) }
  let!(:nearest_weather_condition) { create(:weather_condition, timestamp: 250_000) }

  before do
    create(:weather_condition, timestamp: 100_000)
    create(:weather_condition, timestamp: 200_000)
    create(:weather_condition, timestamp: 300_000)
  end

  context 'when matched condition' do
    let(:select_timestamp) { 150_000 }

    it 'returns matched condition' do
      expect(selector).to eq(matched_weather_condition)
    end
  end

  context 'when nearest condition' do
    let(:select_timestamp) { 225_000 }

    it 'returns nearest condition' do
      expect(selector).to eq(nearest_weather_condition)
    end
  end
end
