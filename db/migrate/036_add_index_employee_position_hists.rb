class AddIndexEmployeePositionHist < ActiveRecord::Migration
  def self.up
    add_index :position_number_id
  end
  
  def self.down
    remove_index :position_number_id
  end
end
