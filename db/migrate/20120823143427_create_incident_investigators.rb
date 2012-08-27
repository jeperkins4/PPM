class CreateIncidentInvestigators < ActiveRecord::Migration
  def change
    create_table :incident_investigators do |t|
      t.integer :investigator_id
      t.integer :incident_id

      t.timestamps
    end
  end
end
