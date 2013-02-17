class CreateLitters < ActiveRecord::Migration
  def change
    create_table :litters do |t|
      t.integer :mother_id
      t.integer :father_id
      t.integer :event_id
      t.string :name

      t.timestamps
    end
  end
end
