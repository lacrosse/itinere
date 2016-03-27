class TripPlan < ActiveRecord::Base
  belongs_to :user
  has_many :trip_days, dependent: :destroy

  enum unit: %w(metric imperial)

  validates :title, presence: true

  before_create :generate_alternate_id
  before_save :populate_weather, if: :unit_changed?

  scope :published, -> { where published: true }

  def start_location_lat
    start_location.split(/,\s*/)[0]
  end

  def start_location_lon
    start_location.split(/,\s*/)[1]
  end

  def finish_location_lat
    finish_location.split(/,\s*/)[0]
  end

  def finish_location_lon
    finish_location.split(/,\s*/)[1]
  end

  def generate_alternate_id
    loop do
      self.alternate_id = SecureRandom.hex
      break unless self.class.exists?(alternate_id: alternate_id)
    end
  end

  def populate_weather
    UpdateWeatherForecastJob.perform_now(self)
  end
end
