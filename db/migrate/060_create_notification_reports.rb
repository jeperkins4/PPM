class CreateNotificationReports < ActiveRecord::Migration
  def self.up
    create_table :notification_reports do |t|
      t.column :user_id, :integer
      t.column :facility_id, :integer
      t.column :eom_offset, :integer
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
    add_index :notification_reports, [:user_id]
    add_index :notification_reports, [:facility_id, :eom_offset]
  end

  def self.down
    drop_table :notification_reports
  end
end
