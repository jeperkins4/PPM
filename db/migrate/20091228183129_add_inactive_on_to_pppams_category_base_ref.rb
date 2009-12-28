class AddInactiveOnToPppamsCategoryBaseRef < ActiveRecord::Migration
  def self.up
    add_column :pppams_category_base_refs, :inactive_on, :datetime
  end

  def self.down
    remove_column :pppams_category_base_refs, :inactive_on
  end
end
