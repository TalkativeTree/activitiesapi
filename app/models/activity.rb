class Activity < ActiveRecord::Base
  validates_presence_of :title, :vendor, :start_time, :date, :price
  has_many :bookings
  belongs_to :recurrence
end
