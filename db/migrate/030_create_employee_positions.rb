class CreateEmployeePositions < ActiveRecord::Migration
  def self.up
    create_table :employee_positions do |t|
      t.column :position_number_id, :integer
      t.column :employee_id, :integer
      t.column :start_date, :date
      t.column :end_date, :date
      t.column :salary, :decimal
    end
  end

  def self.down
    drop_table :employee_positions
  end
end
