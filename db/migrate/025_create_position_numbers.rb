class CreatePositionNumbers < ActiveRecord::Migration
  def self.up
    create_table :position_numbers do |t|
      t.column :position_id, :integer
      t.column :position_num, :integer
      t.column :contracted_position, :integer
      t.column :waiver_approval_date, :date
      t.column :iwtf, :integer
    end
  end

  def self.down
    drop_table :position_numbers
  end
end
