class AddDatetimeColumnToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :date_time, :datetime 
  end
end
