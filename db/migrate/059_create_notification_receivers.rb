class CreateNotificationReceivers < ActiveRecord::Migration
  def self.up
    create_table :notification_receivers do |t|
      t.column :user_id, :integer
      t.column :facility_id, :integer
      t.column :status, :string
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
    add_index :notification_receivers, [:user_id, :status]
    add_index :notification_receivers, [:facility_id, :status]
  end

  def self.down
    drop_table :notification_receivers
  end
end
