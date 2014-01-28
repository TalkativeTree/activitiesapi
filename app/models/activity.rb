class Activity < ActiveRecord::Base
  validates_presence_of :title, :vendor, :start_time, :date, :price
  has_many :bookings
  belongs_to :recurrence

  def self.editable_attributes
    ["title", "vendor", "date", "start_time", "price" ]
  end

  def self.build_from_json activity
    Activity.new title: activity[:title], 
      vendor: activity[:vendor], date: activity[:date],
      start_time: activity[:start_time], price: activity[:price]
  end

  def self.update_from_json! id, activity
    existing_activity = Activity.find_by_id id
    #break this into another testable method
    new_attributes = Activity.editable_attributes.each_with_object({}) do |attribute, object|
      if activity.has_key? attribute
        object[attribute] = activity[attribute]
      end
    end
    existing_activity.update_attributes new_attributes
  end
end
