class AddFacilityIdCols < ActiveRecord::Migration
  def self.up
    add_column :pppams_categories, :facility_id, :integer
  end

  def self.down
    remove_column :pppams_categories, :facility_id, :integer
  end
end
