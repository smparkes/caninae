class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :entity_id
      t.string :integer
      t.string :entity_type
      t.string :string
      t.string :type
      t.date :date
      t.time :time
      t.integer :location_id

      t.timestamps
    end
  end
end
