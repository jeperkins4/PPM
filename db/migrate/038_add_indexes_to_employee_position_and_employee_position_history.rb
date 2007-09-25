class AddIndexesToEmployeePositionAndEmployeePositionHistory < ActiveRecord::Migration
  def self.up
    add_index :employee_positions, :position_number_id
    add_index :employee_positions, :employee_id
    add_index :employee_position_hists, :position_number_id
    add_index :employee_position_hists, :employee_id
  end
  
  def self.down
    remove_index :employee_positions, :position_number_id
    remove_index :employee_positions, :employee_id
    remove_index :employee_position_hists, :position_number_id
    remove_index :employee_position_hists, :employee_id
    
  end
end