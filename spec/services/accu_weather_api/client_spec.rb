# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccuWeatherApi::Client do
  subject(:client) { described_class.new }
  before do
    # Do nothingr
  end

  let(:expected_result) do
    [
      {
        "LocalObservationDateTime"=>"2023-01-30T14:13:00+01:00",
        "EpochTime"=>1675084380,
        "WeatherText"=>"Snow",
        "WeatherIcon"=>22,
        "HasPrecipitation"=>true,
        "PrecipitationType"=>"Snow",
        "IsDayTime"=>true,
        "Temperature"=>{"Metric"=>{"Value"=>0.3, "Unit"=>"C", "UnitType"=>17}, "Imperial"=>{"Value"=>32.0, "Unit"=>"F", "UnitType"=>18}},
        "MobileLink"=>"http://www.accuweather.com/en/pl/bialystok/15-111/current-weather/352559_pc?lang=en-us",
        "Link"=>"http://www.accuweather.com/en/pl/bialystok/15-111/current-weather/352559_pc?lang=en-us"
      }
    ]

  end

  describe "#current_conditions" do
    let(:current_conditions_response) do
      VCR.use_cassette('weather/current_conditions') do
        client.current_conditions
      end
    end

    it 'returns current weather condition' do
      expect(current_conditions_response).to be_kind_of(Array)

      expect(worker.queue).to match [
                                      a_hash_including(:klass => "Class1", :id => 37),
                                      a_hash_including(:klass => "Class2", :id => 42)
                                    ]
    end
  end

  describe "#historical_conditions" do
    let(:historical_conditions_response) do
      VCR.use_cassette('weather/historical_conditions') do
        client.historical_conditions
      end
    end

    it 'returns historical weather condition' do
      expect(historical_conditions_response).to be_kind_of(Array)
    end
  end
end
