# frozen_string_literal: true

class WeatherCondition < ApplicationRecord
  include ActiveModel::Serializers::JSON

  def attributes
    { "temperature": nil, "timestamp": nil }
  end
end
