class Booking < ActiveRecord::Base
  validates_presence_of :user_id, :activity_id
  belongs_to :activity
  belongs_to :user
  belongs_to :recurrence
end
