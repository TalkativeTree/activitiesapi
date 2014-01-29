namespace :activities do
  desc "seed activities"
  task :create  => :environment do
    15.times do |n|
      date = Date.new(2014,06,11) + n.days
      if n % 5 == 0
        title = "surfing"
        name = "jane #{n}"
      elsif n % 3 == 0 
        title = "climbing"
        name = "jim #{n}"
      else
        title = "running"
        name = "the dude #{n}"
      end
      activity = Activity.create date: date, title: title, vendor: "Mr. Surfer", start_time: "13:00", price: 2500, capacity: 4
      user = User.create name: name
      booking = Booking.create user_id: user.id, activity_id: activity.id
    end

  end

end

