class CreateNonCompFollowUps < ActiveRecord::Migration
  def self.up
    create_table :non_comp_follow_ups do |t|
      t.column :follow_up, :text
      t.column :non_comp_issue_id, :integer
      t.column :created_on, :date
      t.column :updated_on, :date
      t.column :created_by, :integer
      t.column :updated_by, :integer
    end
  end

  def self.down
    drop_table :non_comp_follow_ups
  end
end
