class AddToFacilities < ActiveRecord::Migration
  def self.up
    add_column :facilities, :warden, :string
    add_column :facilities, :contract_monitor, :string
  end

  def self.down
    remove_column :facilities, :warden
    remove_column :facilities, :contract_monitor
  end
end
