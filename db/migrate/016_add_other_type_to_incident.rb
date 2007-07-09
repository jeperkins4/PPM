class AddOtherTypeToIncident < ActiveRecord::Migration
  def self.up
    add_column :incidents, :incident_type_other, :string
  end

  def self.down
    remove_column :incidents, :incident_type_other
  end
end
