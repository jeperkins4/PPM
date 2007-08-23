class CreateIncidents < ActiveRecord::Migration
  def self.up
    create_table :incidents do |t|
      t.column :incident_date, :date
      t.column :reported_date, :date
      t.column :inspector_general, :date
      t.column :description, :text
      t.column :incident_type_id, :integer
      t.column :facility_id, :integer
      t.column :contract_manager_notified_date, :date
      t.column :bureau_notified_date, :date
      t.column :warden_notified_date, :date
      t.column :facility_investigation_complete_date, :date
      t.column :action_type_id, :integer
    end
  end

  def self.down
    drop_table :incidents
  end
end
