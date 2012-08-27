class CreatePppamsIssueFollowUps < ActiveRecord::Migration
  def change
    create_table :pppams_issue_follow_ups do |t|
      t.text :comment
      t.integer :pppams_issue_id
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
  end
end
