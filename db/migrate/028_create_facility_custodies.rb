class CreateFacilityCustodies < ActiveRecord::Migration
  def self.up
    create_table :facility_custodies do |t|
      t.column :facility_id, :integer
      t.column :custody_type_id, :integer
    end
  end

  def self.down
    drop_table :facility_custodies
  end
end
