class CreateAddAttributesToActivities < ActiveRecord::Migration
  def change
    [[:date, :date], [:start_time, :time], [:price, :integer] ].each do |attribute|
      add_column :activities, attribute[0], attribute[1]
    end
  end
end
