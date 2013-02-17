class CreateAnimalOwners < ActiveRecord::Migration
  def change
    create_table :animal_owners do |t|
      t.integer :animal_id
      t.integer :owner_id

      t.timestamps
    end
  end
end
