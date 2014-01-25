class Recurrence < ActiveRecord::Base
  validates_presence_of :start_date, :stop_date, :pattern, :activity_id
  has_many :activities

end
