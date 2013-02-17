class CreateAnimalBreeders < ActiveRecord::Migration
  def change
    create_table :animal_breeders do |t|
      t.integer :animal_id
      t.integer :breeder_id

      t.timestamps
    end
  end
end
