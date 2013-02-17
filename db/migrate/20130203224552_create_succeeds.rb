class CreateSucceeds < ActiveRecord::Migration
  def change
    create_table :succeeds do |t|
      t.integer :first
      t.integer :second

      t.timestamps
    end
  end
end
