class CreatePppamsIssues < ActiveRecord::Migration
  def change
    create_table :pppams_issues do |t|
      t.string :pppams_issue_number
      t.integer :pppams_issue_status
      t.string :receiver
      t.date :received_on
      t.integer :facility_id
      t.string :reported_by
      t.string :inmate_details
      t.string :inmate_id
      t.string :description
      t.date :cm_response_due_on
      t.date :cm_response_on
      t.date :resolved_on
      t.string :category
      t.integer :pppams_issue_id
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
  end
end
