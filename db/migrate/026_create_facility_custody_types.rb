class CreateFacilityCustodyTypes < ActiveRecord::Migration
  def self.up
    create_table :facility_custody_types do |t|
      t.column :facility_id, :integer
      t.column :custody_type_id, :integer
    end
  end

  def self.down
    drop_table :facility_custody_types
  end
end
