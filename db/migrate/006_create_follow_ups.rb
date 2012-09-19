class CreateFollowUps < ActiveRecord::Migration
  def self.up
    create_table :follow_ups do |t|
      t.column :follow_up, :text
      t.column :follow_up_date, :date
      t.column :incident_id, :integer
    end
  end

  def self.down
    drop_table :follow_ups
  end
end
