class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.integer :uploadable_id
      t.string :uploadable_type
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
