class CreatePreceeds < ActiveRecord::Migration
  def change
    create_table :preceeds do |t|
      t.integer :first
      t.integer :second

      t.timestamps
    end
  end
end
