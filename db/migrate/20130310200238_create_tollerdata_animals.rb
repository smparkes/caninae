class CreateTollerdataAnimals < ActiveRecord::Migration
  def change
    create_table :tollerdata_animals do |t|

      t.timestamps
    end
  end
end
