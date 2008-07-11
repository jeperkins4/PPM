class AddBaseRefLinkCol < ActiveRecord::Migration
  def self.up
    add_column :pppams_indicator_base_refs, :pppams_category_base_ref_id, :integer
  end

  def self.down
    remove_column :pppams_indicator_base_refs, :pppams_category_base_ref_id, :integer
  end
end
