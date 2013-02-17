class CreatePersonKennels < ActiveRecord::Migration
  def change
    create_table :person_kennels do |t|
      t.integer :person_id
      t.integer :kennel_id

      t.timestamps
    end
  end
end
