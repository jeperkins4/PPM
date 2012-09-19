class AddCreatedOnToPositionNumbers < ActiveRecord::Migration
  def self.up
    add_column :position_numbers, :created_on, :date
  end
  
  def self.down
    remove_column :position_numbers, :created_on
  end
end