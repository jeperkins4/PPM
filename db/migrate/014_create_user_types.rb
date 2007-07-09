class CreateUserTypes < ActiveRecord::Migration
  def self.up
    create_table :user_types do |t|
      t.column :user_type, :string
      t.column :description, :text
      t.column :access_level_id, :integer
    end
  end

  def self.down
    drop_table :user_types
  end
end
