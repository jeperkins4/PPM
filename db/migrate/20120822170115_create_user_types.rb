class CreateUserTypes < ActiveRecord::Migration
  def change
    create_table :user_types do |t|
      t.string :name
      t.string :description
      t.integer :access_level_id

      t.timestamps
    end
  end
end
