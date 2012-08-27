class CreateNonCompFollowUps < ActiveRecord::Migration
  def change
    create_table :non_comp_follow_ups do |t|
      t.text :comment
      t.integer :non_comp_issue_id
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
  end
end
