class Api::V1::HealthController < ApplicationController
  def index
    render :ok
  end
end
