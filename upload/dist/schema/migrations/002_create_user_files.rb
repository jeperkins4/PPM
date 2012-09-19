class CreateUserFiles < ActiveRecord::Migration
  def self.up
    create_table :user_files do |t|
      t.column :filename, :string, :null => false
    end
  end

  def self.down
    drop_table :user_files
  end
end
