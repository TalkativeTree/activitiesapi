class ChangeAttributesonRecurrence < ActiveRecord::Migration
  def change
    [["start", "start_date"], ["stop", "stop_date"]].each do |column|
      rename_column :recurrences, column[0].to_sym, column[1].to_sym
    end
  end
end
