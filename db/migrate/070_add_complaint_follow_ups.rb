class AddComplaintFollowUps < ActiveRecord::Migration
  def self.up
    create_table :complaint_follow_ups do |t|
      t.column :follow_up, :text
      t.column :complaint_id, :integer
      t.column :created_on, :date
      t.column :updated_on, :date
      t.column :created_by, :date
      t.column :updated_by, :date
    end
  end

  def self.down
    drop_table :complaint_follow_ups
  end
end
