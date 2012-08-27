class CreatePppamsCategoryBaseRefs < ActiveRecord::Migration
  def change
    create_table :pppams_category_base_refs do |t|
      t.string :name
      t.integer :pppams_category_group_id

      t.timestamps
    end
  end
end
