FactoryBot.define do
  factory :weather_condition do
    temperature { SecureRandom.rand(-50.0..50.0).round(1) }
    timestamp { Time.utc.now.to_i }
  end
end