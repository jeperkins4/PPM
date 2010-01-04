class AddInactiveOnToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :inactive_on, :datetime
    add_column :users, :inactive_comment, :string
  end

  def self.down
    remove_column :users, :inactive_comment
    remove_column :users, :inactive_on
  end
end
