class CreateClearances < ActiveRecord::Migration
  def change
    create_table :clearances do |t|
      t.integer :animal_id

      t.timestamps
    end
  end
end
