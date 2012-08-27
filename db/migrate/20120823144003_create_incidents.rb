class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.date :incident_on
      t.date :reported_on
      t.date :inspector_general_on
      t.text :description
      t.integer :incident_type_id
      t.integer :facility_id
      t.date :contract_manager_notified_on
      t.date :bureau_notified_on
      t.date :warden_notified_on
      t.date :facility_investigation_completed_on
      t.integer :action_type_id
      t.string :incident_type_other
      t.integer :incident_class_id
      t.integer :investigator_id
      t.string :mins
      t.string :action_type_other
      t.string :designee_name
      t.boolean :contract_manager_notified
      t.integer :warden_notified
      t.boolean :bureau_notified
      t.boolean :facility_investigation_complete
      t.boolean :investigation_closed
      t.date :investigation_closed_on
      t.string :entity_closing

      t.timestamps
    end
  end
end
