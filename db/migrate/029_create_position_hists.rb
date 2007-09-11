class CreatePositionHists < ActiveRecord::Migration
  def self.up
    create_table :position_hists do |t|
      t.column :title, :string
      t.column :position_type_id, :integer
      t.column :salary, :decimal
      t.column :description, :text
      t.column :facility_id, :integer
      t.column :create_date, :date
   end
  end

  def self.down
    drop_table :position_hists
  end
end
