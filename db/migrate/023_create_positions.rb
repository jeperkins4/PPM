class CreatePositions < ActiveRecord::Migration
  def self.up
    create_table :positions do |t|
      t.column :title, :string
      t.column :position_type_id, :integer
      t.column :salary, :decimal
      t.column :description, :text
      t.column :facility_id, :integer
   end
  end

  def self.down
    drop_table :positions
  end
end
