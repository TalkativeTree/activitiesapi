class CreateRecurrences < ActiveRecord::Migration
  def change
    create_table :recurrences do |t|
      t.date :start
      t.date :stop
      t.integer :pattern
      t.integer :activity_id

      t.timestamps
    end
  end
end
