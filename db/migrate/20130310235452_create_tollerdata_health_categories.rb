class CreateTollerdataHealthCategories < ActiveRecord::Migration
  def change
    create_table :tollerdata_health_categories do |t|
      t.string :name
      t.timestamps
    end
  end
end
