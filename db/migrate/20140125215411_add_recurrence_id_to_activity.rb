class AddRecurrenceIdToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :recurrence_id, :integer
  end
end
