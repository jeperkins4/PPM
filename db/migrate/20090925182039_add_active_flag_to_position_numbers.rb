class AddActiveFlagToPositionNumbers < ActiveRecord::Migration
  def self.up
    add_column :position_numbers, :active_flag, :boolean, :default => true
  end

  def self.down
    remove_column :position_numbers, :active_flag
  end
end
