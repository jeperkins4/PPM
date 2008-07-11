class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.column :to_email, :string
      t.column :from_email, :string
      t.column :subject, :string
      t.column :body, :text
      t.column :status, :string
      t.column :created_by, :integer
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
    add_index :notifications, :status
  end

  def self.down
    drop_table :notifications
  end
end
