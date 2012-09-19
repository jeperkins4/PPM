class AddBaseRefIdCols < ActiveRecord::Migration
  def self.up
    add_column :pppams_categories, :pppams_category_base_ref_id, :integer
    add_column :pppams_indicators, :pppams_indicator_base_ref_id, :integer
  end

  def self.down
    remove_column :pppams_categories, :pppams_category_base_ref_id, :integer
    remove_column :pppams_indicators, :pppams_indicator_base_ref_id, :integer
  end
end

