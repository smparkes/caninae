class CreateDominates < ActiveRecord::Migration
  def change
    create_table :dominates do |t|
      t.integer :dominator_id
      t.integer :dominated_id

      t.timestamps
    end
  end
end
