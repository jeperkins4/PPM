class CreatePppamsIndicatorBaseRefs < ActiveRecord::Migration
  def change
    create_table :pppams_indicator_base_refs do |t|
      t.string :question
      t.integer :pppams_category_base_ref_id

      t.timestamps
    end
  end
end
