class CreateWeatherConditions < ActiveRecord::Migration[6.1]
  def change
    create_table :weather_conditions do |t|
      t.float :temperature
      t.integer :timestamp

      t.timestamps
    end
  end
end
