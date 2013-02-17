class CreateTitles < ActiveRecord::Migration
  def change
    create_table :titles do |t|
      t.integer :registry_id
      t.string :name
      t.string :abbreviation
      t.boolean :prefix

      t.timestamps
    end
  end
end
