class AddFacilityIdIndexToPppamsCategories < ActiveRecord::Migration
  def self.up
    add_index :pppams_categories, :facility_id, :name => 'facility_id'
  end

  def self.down
    remove_index :pppams_categories, :name => 'facility_id'
  end
end
