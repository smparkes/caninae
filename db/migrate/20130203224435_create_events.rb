class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :entity_id
      t.string :entity_type
      t.string :event_type
      t.date :date
      t.integer :year
      t.integer :month
      t.integer :day
      t.time :time
      t.integer :hour
      t.integer :minute
      t.integer :second
      t.string :timezone
      t.integer :location_id
      t.timestamps
    end
  end
end
