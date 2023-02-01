require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :faraday
  config.filter_sensitive_data('<ACCUWEATHER_API_KEY>') {
    ENV.fetch('ACCUWEATHER_API_KEY', 'hidden')
  }
end
