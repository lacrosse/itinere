class TripPlan < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true

  before_create :generate_alternate_id

  scope :published, -> { where published: true }

  def generate_alternate_id
    loop do
      self.alternate_id = SecureRandom.hex
      break unless self.class.exists?(alternate_id: alternate_id)
    end
  end
end
