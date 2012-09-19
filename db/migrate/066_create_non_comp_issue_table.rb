class CreateNonCompIssueTable < ActiveRecord::Migration
  def self.up
    create_table :non_comp_issues do |t|
      t.column :facility_id, :integer
      t.column :nci_status, :integer
      t.column :details, :text
      t.column :requirement, :text
      t.column :discovery_date, :date
      t.column :notification_date, :date
      t.column :cap_due_date, :date
      t.column :cap_review_date, :date
      t.column :cap_forwarded_date, :date
      t.column :resolved_date, :date
      t.column :created_on, :date
      t.column :updated_on, :date
      t.column :created_by, :integer
      t.column :updated_by, :integer
      t.column :notes, :text
    end
  end

  def self.down
    drop_table :non_comp_issues
  end
end
