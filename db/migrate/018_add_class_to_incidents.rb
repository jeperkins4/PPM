class AddClassToIncidents < ActiveRecord::Migration
  def self.up
    add_column :incidents, :incident_class_id, :integer
  end

  def self.down
    remove_column :incidents, :incident_class_id
  end
end
