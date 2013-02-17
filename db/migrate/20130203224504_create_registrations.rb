class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :registry_id
      t.integer :animal_id
      t.integer :registration_number
      t.date :date

      t.timestamps
    end
  end
end
