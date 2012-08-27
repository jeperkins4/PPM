class CreatePositionNumbers < ActiveRecord::Migration
  def change
    create_table :position_numbers do |t|
      t.integer :position_id
      t.string :position_num
      t.integer :position_type_id
      t.date :waiver_approval_date
      t.boolean :active
      t.date :inactive_on
      t.string :inactive_comment

      t.timestamps
    end
  end
end
