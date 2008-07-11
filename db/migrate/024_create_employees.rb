class CreateEmployees < ActiveRecord::Migration
  def self.up
    create_table :employees do |t|
      t.column :facility_id, :integer
      t.column :first_name, :string
      t.column :last_name, :string
      t.column :emplid, :string   
      t.column :active, :integer
    end
  end

  def self.down
    drop_table :employees
  end
end
