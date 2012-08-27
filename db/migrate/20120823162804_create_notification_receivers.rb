class CreateNotificationReceivers < ActiveRecord::Migration
  def change
    create_table :notification_receivers do |t|
      t.integer :user_id
      t.integer :facility_id
      t.string :status

      t.timestamps
    end
  end
end
