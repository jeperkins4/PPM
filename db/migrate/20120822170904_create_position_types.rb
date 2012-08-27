class CreatePositionTypes < ActiveRecord::Migration
  def change
    create_table :position_types do |t|
      t.string :name
      t.string :description
      t.boolean :deductable
      t.integer :deduction_days
      t.integer :facility_id

      t.timestamps
    end
  end
end
