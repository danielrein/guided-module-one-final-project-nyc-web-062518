class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :zipcode
      t.string :event_type
      t.date :date
    end
  end
end
