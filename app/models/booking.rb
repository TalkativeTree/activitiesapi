class Booking < ActiveRecord::Base
  validates_presence_of :user_id, :activity_id
  belongs_to :activity
  belongs_to :user
  belongs_to :recurrence

  def self.build_from_json booking
    Booking.new user_id: booking[:user_id], activity_id: booking[:activity_id]
  end
end
