class AddEntityClosingIncidentToIncidents < ActiveRecord::Migration
  def self.up
    add_column :incidents, :entity_closing, :string
  end

  def self.down
    remove_column :incidents, :entity_closing
  end
end
