class CreateIncidents < ActiveRecord::Migration
  def self.up
    create_table :incidents do |t|
      t.column :incident_date, :date
      t.column :reported_date, :date
      t.column :inspector_general, :date
      t.column :description, :text
      t.column :incident_type_id, :integer
      t.column :facility_id, :integer
      t.column :contract_monitor_notified, :date
      t.column :bureau_notified, :date
      t.column :warden_notified, :date
      t.column :investigation_completed, :date
      t.column :action_type_id, :integer
    end
  end

  def self.down
    drop_table :incidents
  end
end
