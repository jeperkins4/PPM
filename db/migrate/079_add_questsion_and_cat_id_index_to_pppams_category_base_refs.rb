class AddQuestsionAndCatIdIndexToPppamsCategoryBaseRefs < ActiveRecord::Migration
  def self.up
    PppamsIndicatorBaseRef.connection.execute "CREATE INDEX question ON pppams_indicator_base_refs (question(15));"
    add_index :pppams_indicator_base_refs, :pppams_category_base_ref_id, :name => 'pppams_cat_base_id'

  end

  def self.down
    remove_index :pppams_indicator_base_refs, :name => 'question'
    remove_index :pppams_indicator_base_refs, :name => 'pppams_cat_base_id'
  end
end
