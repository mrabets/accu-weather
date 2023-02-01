module Weather
  class Cleaner
    BATCH_SIZE = 10_000

    def self.call(*args)
      new(*args).call
    end

    def call
      old_records.in_batches(of: BATCH_SIZE, &:delete_all)
    end

    private

    def old_records
      WeatherCondition.where('timestamp <= ?', timestamp_trait)
    end

    def timestamp_trait
      (Time.now.utc - 3.months).to_i
    end
  end
end