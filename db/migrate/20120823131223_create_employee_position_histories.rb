class CreateEmployeePositionHistories < ActiveRecord::Migration
  def change
    create_table :employee_position_histories do |t|
      t.integer :position_number_id
      t.integer :employee_id
      t.date :start_date
      t.date :end_date
      t.decimal :salary, :precision => 10, :scale => 2

      t.timestamps
    end
  end
end
