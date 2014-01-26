class AddOccurrencesToRecurrence < ActiveRecord::Migration
  def change
    add_column :recurrences, :occurrences, :integer
  end
end
