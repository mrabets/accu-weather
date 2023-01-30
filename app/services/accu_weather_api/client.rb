# frozen_string_literal: true

module AccuWeatherApi
  class Client
    API_HOST = 'http://dataservice.accuweather.com/'

    attr_reader :api_key, :location_key

    def initialize(api_key = ENV.fetch('ACCUWEATHER_API_KEY', location_key = '352559_PC'))
      @api_key = api_key
      @location_key = location_key
    end

    def current_conditions
      get("currentconditions/v1/#{location_key}")
    end

    def historical_conditions
      get("currentconditions/v1/#{location_key}/historical/24")
    end

    private

    def connection
      @connection ||= Faraday.new(
        url: API_HOST,
        params: { apikey: api_key },
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    def get(endpoint)
      request(:get, endpoint)
    end

    def request(http_method, endpoint, params: {})
      response = connection.public_send(http_method, endpoint, params)

      parsed_response = JSON.parse(response.body)

      return parsed_response if response.status == 200

      raise "Code: #{response.status}, response: #{response.body}"
    end
  end
end
