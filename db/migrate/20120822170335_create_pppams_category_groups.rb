class CreatePppamsCategoryGroups < ActiveRecord::Migration
  def change
    create_table :pppams_category_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
