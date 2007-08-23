class CreatePositions < ActiveRecord::Migration
  def self.up
    create_table :positions do |t|
      t.column :title, :string
      t.column :position_type_id, :integer
      t.column :salary, :decimal
      t.column :description, :text
      t.column :facility_id, :integer
      t.column :position_number, :integer
      t.column :contracted_position, :integer
      t.column :date_of_waiver_approval, :date
      t.column :iwtf_position, :integer
    end
  end

  def self.down
    drop_table :positions
  end
end
