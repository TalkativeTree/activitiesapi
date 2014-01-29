class Recurrence < ActiveRecord::Base
  validates_presence_of :start_date, :stop_date, :pattern
  has_many :activities
  PATTERNS = { :"1" => "j", :"2" => "W", :"3" => "m" }
  # 1, daily, 2, weekly, 3, monthly

  def self.build_from_activity activity, recurrence
    activity = Activity.build_from_json activity
    @recurrence = Recurrence.new  start_date: recurrence[:start_date], 
      stop_date: recurrence[:stop_date], pattern: recurrence[:pattern]
    @recurrence.save
    @recurrence.set_occurrences!
    @recurrence.create_activities! activity
    @recurrence
  end

  def set_occurrences! 
    pattern = self.pattern.to_s.to_sym
    start = self.start_date.strftime("%Y%#{PATTERNS[pattern]}").to_i
    stop = self.stop_date.strftime("%Y%#{PATTERNS[pattern]}").to_i
    self.occurrences = stop - start
  end

  def create_activities! activity
    self.set_occurrences! if self.occurrences.nil?
    return nil if self.occurrences.nil?
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
