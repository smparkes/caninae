class CreateKennelLitters < ActiveRecord::Migration
  def change
    create_table :kennel_litters do |t|
      t.integer :kennel_id
      t.integer :litter_id

      t.timestamps
    end
  end
end
