class CreateFacilities < ActiveRecord::Migration
  def self.up
    create_table :facilities do |t|
      t.column :facility, :string
      t.column :shortname, :string
      t.column :address1, :string
      t.column :address2, :string
      t.column :city, :string
      t.column :state, :string
      t.column :zip, :string
      t.column :phone, :string
    end
  end

  def self.down
    drop_table :facilities
  end
end
