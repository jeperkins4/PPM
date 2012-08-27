class CreateFollowUps < ActiveRecord::Migration
  def change
    create_table :follow_ups do |t|
      t.string :comment
      t.date :commented_at
      t.integer :incident_id
      t.integer :user_id

      t.timestamps
    end
  end
end
