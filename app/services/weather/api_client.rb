class Weather::ApiClient
  attr_reader :api_token
  def initialize(api_token = nil)
    api_token = oauth_token
  end

  def connection
    @connection ||= Faraday.new(
      url: api_host,
      params: {apikey: api_key},
      headers: {'Content-Type' => 'application/json'}
    )
  end

  def get(endpoint)
    perform_request(:get, endpoint)
  end

  def perform_request(http_method, endpoint)
    response = connection.public_send(http_method) do |request|
      request.url(endpoint)
    end

    process_response(response)
  rescue Faraday::Error => exception
    "Faraday exception was raised => #{exception}"
  end

  def process_response(response)
    case response.status
    when 200..299
      JSON.parse(response.body)
    else
      handle_api_error(response)
    end
  end

  def handle_api_error(response)
    result = JSON.parse(response.body)

    raise "Error: #{result.fetch("Code")}. #{result.fetch("Message")}}"
  end

  def setup_connection(faraday)
    faraday.adapter :typhoeus
  end

  def api_key
    ENV.fetch('ACCUWEATHER_API_KEY')
  end

  def api_host
    "http://dataservice.accuweather.com/"
  end

  def location_key
    "352559_PC".freeze
  end
end