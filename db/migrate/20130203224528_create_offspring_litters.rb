class CreateOffspringLitters < ActiveRecord::Migration
  def change
    create_table :offspring_litters do |t|
      t.integer :litter_id
      t.integer :offspring_id

      t.timestamps
    end
  end
end
