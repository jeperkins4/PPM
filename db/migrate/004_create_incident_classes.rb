class CreateIncidentClasses < ActiveRecord::Migration
  def self.up
    create_table :incident_classes do |t|
      t.column :incident_class, :string
      t.column :description, :text
    end
  end

  def self.down
    drop_table :incident_classes
  end
end
