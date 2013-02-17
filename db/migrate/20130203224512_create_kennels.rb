class CreateKennels < ActiveRecord::Migration
  def change
    create_table :kennels do |t|
      t.string :name
      t.integer :address_id

      t.timestamps
    end
  end
end
