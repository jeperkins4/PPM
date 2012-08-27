class CreateNotificationReports < ActiveRecord::Migration
  def change
    create_table :notification_reports do |t|
      t.integer :user_id
      t.integer :facility_id
      t.integer :eom_offset

      t.timestamps
    end
  end
end
