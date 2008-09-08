class AddComplaintsTable < ActiveRecord::Migration
  def self.up
    create_table :complaints do |t|
      t.column :complaint_number, :string
      t.column :complaint_status, :integer
      t.column :user_id, :integer
      t.column :facility_id, :integer
      t.column :complaint_type, :string
      t.column :complaint_date, :date
      t.column :received_date, :date
      t.column :complainer_contact, :text
      t.column :inmate_details, :text
      t.column :description, :text
      t.column :MRS_assigned_date, :date
      t.column :CM_assigned_date, :date
      t.column :CM_response_due_date, :date
      t.column :CM_response_date, :date
      t.column :response_sent_date, :date
      t.column :resolved_date, :date
      t.column :created_on, :date
      t.column :updated_on, :date
      t.column :created_by, :integer
      t.column :updated_by, :integer
    end
  end

  def self.down
    drop_table :complaints
  end
end
