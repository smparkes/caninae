class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.integer :title_id
      t.integer :event_id

      t.timestamps
    end
  end
end
