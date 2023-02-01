# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Weather::Cleaner do
  subject(:cleaner) { described_class }

  before do
    create(:weather_condition, timestamp: Time.now.utc - 1.month)
    create(:weather_condition, timestamp: Time.now.utc - 2.months)
    create(:weather_condition, timestamp: Time.now.utc - 3.months)
    create(:weather_condition, timestamp: Time.now.utc - 4.months)
    create(:weather_condition, timestamp: Time.now.utc - 5.months)
  end

  it 'removes records with old timestamp' do
    expect { cleaner.call }.to change(WeatherCondition, :count).from(5).to(2)
  end
end
