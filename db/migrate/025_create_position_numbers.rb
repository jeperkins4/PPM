class CreatePositionNumbers < ActiveRecord::Migration
  def self.up
    create_table :position_numbers do |t|
      t.column :position_id, :integer
      t.column :position_num, :string
      t.column :position_type, :string
      t.column :waiver_approval_date, :date
    end
  end

  def self.down
    drop_table :position_numbers
  end
end
