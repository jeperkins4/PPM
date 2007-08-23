class CreatePositionArchives < ActiveRecord::Migration
  def self.up
    create_table :position_archives do |t|
      t.column :position_id, :integer
      t.column :filled_date, :date
      t.column :vacant_date, :date
      t.column :employee_id_exit, :integer
      t.column :employee_id_start, :integer
    end
  end

  def self.down
    drop_table :position_archives
  end
end
