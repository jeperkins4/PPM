class CreateIncidentInvestigators < ActiveRecord::Migration
  def self.up
    create_table :incident_investigators do |t|
      t.column :investigator_id, :integer
      t.column :incident_id, :integer
    end
  end

  def self.down
    drop_table :incident_investigators
  end
end
