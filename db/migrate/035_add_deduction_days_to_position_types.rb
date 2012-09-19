class AddDeductionDaysToPositionTypes < ActiveRecord::Migration
  def self.up
    add_column :position_types, :deduction_days, :integer
  end
  
  def self.down
    remove_column :position_types, :deduction_days
  end
end