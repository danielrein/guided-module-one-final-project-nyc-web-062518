class CreatePrograms < ActiveRecord::Migration[5.0]
  def change
    create_table :programs do |t|
      t.integer :user_id
      t.integer :event_id
      t.integer :restaurant_id
    end
  end
end
