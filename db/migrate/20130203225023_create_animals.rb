class CreateAnimals < ActiveRecord::Migration
  def change
    create_table :animals do |t|
      t.string :name
      t.string :call_name
      t.integer :mother_id
      t.integer :father_id
      t.string :sex
      t.integer :litter_id
      t.integer :address_id
      t.date :birth
      t.integer :birth_id
      t.date :death
      t.integer :death_id
      t.string :import_json
      t.timestamps
    end
    change_table :animals do |t|
      t.index :mother_id
      t.index :father_id
      t.index :sex
      t.index :litter_id
      t.index :birth
      t.index :death
    end
  end
end
