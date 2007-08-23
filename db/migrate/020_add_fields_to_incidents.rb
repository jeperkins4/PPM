class AddFieldsToIncidents < ActiveRecord::Migration
  def self.up
    add_column :incidents, :mins, :string
    add_column :incidents, :action_type_other, :string
    add_column :incidents, :designee_name, :string
    add_column :incidents, :contract_manager_notified, :integer
    add_column :incidents, :warden_notified, :integer
    add_column :incidents, :bureau_notified, :integer
    add_column :incidents, :facility_investigation_complete, :integer
    add_column :incidents, :investigation_closed, :integer
    add_column :incidents, :investigation_closed_date, :date
  end

  def self.down
    remove_column :incidents, :mins
    remove_column :incidents, :action_type_other
    remove_column :incidents, :designee_name
    remove_column :incidents, :contract_manager_notified
    remove_column :incidents, :warden_notified
    remove_column :incidents, :bureau_notified
    remove_column :incidents, :facility_investigation_complete
    remove_column :incidents, :investigation_closed
    remove_column :incidents, :investigation_closed_date
  end
end
