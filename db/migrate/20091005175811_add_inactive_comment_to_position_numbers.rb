class AddInactiveCommentToPositionNumbers < ActiveRecord::Migration
  def self.up
    add_column :position_numbers, :inactive_comment, :text
  end

  def self.down
    remove_column :position_numbers, :inactive_comment
  end
end
