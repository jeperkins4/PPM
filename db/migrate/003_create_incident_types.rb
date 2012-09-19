class CreateIncidentTypes < ActiveRecord::Migration
  def self.up
    create_table :incident_types do |t|
      t.column :incident_type, :string
      t.column :description, :text
    end
  end

  def self.down
    drop_table :incident_types
  end
end
