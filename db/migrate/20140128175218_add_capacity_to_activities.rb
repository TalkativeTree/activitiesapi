class AddCapacityToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :capacity, :integer, default: 1
  end
end
