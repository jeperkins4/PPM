class AddPrecisionToSalaryOnPositionAndEmployeePositionHist < ActiveRecord::Migration
  def self.up
      change_column :positions, :salary, :decimal, :precision=> 10, :scale=> 2
      change_column :position_hists, :salary, :decimal, :precision=> 10, :scale=> 2
      change_column :employee_position_hists, :salary, :decimal, :precision=> 10, :scale=> 2
    end
    
    def self.down
      raise ActiveRecord::IrreversibleMigration
    end
  end
