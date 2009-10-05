class AddInactiveOnToPositionNumbers < ActiveRecord::Migration
  def self.up
    add_column :position_numbers, :inactive_on, :date
  end

  def self.down
    remove_column :position_numbers, :inactive_on
  end
end
