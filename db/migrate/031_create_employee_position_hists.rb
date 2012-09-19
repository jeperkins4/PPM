class CreateEmployeePositionHists < ActiveRecord::Migration
  def self.up
    create_table :employee_position_hists do |t|
      t.column :position_number_id, :integer
      t.column :employee_id, :integer
      t.column :start_date, :date
      t.column :end_date, :date
      t.column :salary, :decimal
      t.column :create_date, :date
    end
  end

  def self.down
    drop_table :employee_position_hists
  end
end

