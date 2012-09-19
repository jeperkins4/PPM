class ChangeComplaintToPppamsIssue < ActiveRecord::Migration
  def self.up
    add_column :complaints, :category, :string
    rename_table :complaints, :pppams_issues
    rename_table :complaint_follow_ups, :pppams_issue_follow_ups
    rename_column :pppams_issues, :complaint_number, :pppams_issue_number
    rename_column :pppams_issues, :complaint_status, :pppams_issue_status
    rename_column :pppams_issues, :complainer_contact, :reported_by
    rename_column :pppams_issue_follow_ups, :complaint_id, :pppams_issue_id
  end

  def self.down
    rename_column :pppams_issues, :pppams_issue_number, :complaint_number
    rename_column :pppams_issues, :pppams_issue_status, :complaint_status
    rename_column :pppams_issues, :reported_by, :complainer_contact
    rename_column :pppams_issue_follow_ups, :complaint_id, :pppams_issue_id
    rename_table :pppams_issue_follow_ups, :complaint_follow_ups
    rename_table :pppams_issues, :complaints
    remove_column :complaints, :category
  end
end
