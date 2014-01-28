class Activity < ActiveRecord::Base
  validates_presence_of :title, :vendor, :start_time, :date, :price, :capacity
  has_many :bookings
  belongs_to :recurrence

  def self.required_attributes
    ['title', 'vendor', 'date', 'start_time', 'price', 'capacity']
  end

  def self.build_from_json activity
    Activity.new title: activity["title"], 
      vendor: activity["vendor"], date: activity["date"],
      start_time: activity["start_time"], price: activity["price"], capacity: activity["capacity"]
  end

  def self.update_from_json! id, activity
    existing_activity = Activity.find_by_id id
    #break this into another testable method
    new_attributes = Activity.required_attributes.each_with_object({}) do |attribute, object|
      if activity.has_key? attribute
        object[attribute] = activity[attribute]
      end
    end
    existing_activity.update_attributes new_attributes
  end

  def at_capacity?
    if self.bookings.count == self.capacity
      return true
    else
      return false
    end
  end

  def oversubscribed?
      if self.bookings.count > self.capacity
      return true
    else
      return false
    end
  end

  def self.by_range start_date, stop_date
    # what is the idiomatic way to handle this ? 
    begin
      #this seems like it should be polished
      start_date = Date.parse start_date
      stop_date = Date.parse stop_date
      Activity.where(date: start_date..stop_date)
    rescue => e
      return nil
    end
  end

end
