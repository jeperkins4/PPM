class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :recipient
      t.string :sender
      t.string :subject
      t.string :message
      t.string :status
      t.integer :user_id

      t.timestamps
    end
  end
end
