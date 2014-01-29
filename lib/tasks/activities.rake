namespace :activities do
  desc "seed activities"
  task :create  => :environment do
    45.times do |n|
      date = Date.new(2014,06,11) + n.days
      if n % 5 == 0
        title = "surfing"
      elsif n % 3 == 0 
        title = "climbing"
      else
        title = "running"
      end
      Activity.create date: date, title: title, vendor: "Mr. Surfer", start_time: "13:00", price: 2500, capacity: 4
    end

  end

end

