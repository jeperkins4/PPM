class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :firstname, :string
      t.column :lastname, :string
      t.column :name, :string
      t.column :email, :string
      t.column :hashed_password, :string
      t.column :salt, :string
      t.column :user_type_id, :integer
      t.column :facility_id, :integer
    end
  end

  def self.down
    drop_table :users
  end
end
