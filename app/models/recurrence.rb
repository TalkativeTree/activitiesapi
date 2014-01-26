class Recurrence < ActiveRecord::Base
  validates_presence_of :start_date, :stop_date, :pattern, :activity_id
  has_many :activities

  before_create :set_occurrences!

  def self.build_from_activity activity, start_date, stop_date, pattern
    @recurrence = Recurrence.create(activity_id: activity.id, start_date: start_date, stop_date: stop_date, pattern: pattern)
    @recurrence.create_activities! activity
    @recurrence.update_primary_activity activity
    @recurrence
  end

  def set_occurrences! 
    # 1, daily, 2, weekly, 3, monthly
    patterns = { :"1" => "j", :"2" => "W", :"3" => "m" }
    pattern = self.pattern.to_s.to_sym
    start = self.start_date.strftime("%Y%#{patterns[pattern]}").to_i
    stop = self.stop_date.strftime("%Y%#{patterns[pattern]}").to_i
    self.occurrences = stop - start
  end

  def create_activities! activity
    self.occurrences.times do |n|
      incremented_date = self.date_increment n 
      self.activities.create title:  activity.title, 
        vendor: activity.vendor, date: incremented_date, 
        start_time: activity.start_time, price: activity.price 
    end
  end

  def date_increment n
    if self.pattern == 1
      self.start_date + n.days
    elsif self.pattern == 2
      self.start_date + n.weeks
    elsif self.pattern == 3
      self.start_date + n.months
    end
  end

end