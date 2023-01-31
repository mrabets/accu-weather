class AddIndexToTimestamp < ActiveRecord::Migration[6.1]
  def change
    add_index :weather_conditions, :timestamp, unique: true
  end
end
