class CreateAnimalKennels < ActiveRecord::Migration
  def change
    create_table :animal_kennels do |t|
      t.integer :animal_id
      t.integer :kennel_id

      t.timestamps
    end
  end
end
