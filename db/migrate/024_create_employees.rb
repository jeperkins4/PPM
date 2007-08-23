class CreateEmployees < ActiveRecord::Migration
  def self.up
    create_table :employees do |t|
      t.column :first_name, :string
      t.column :last_name, :string
      t.column :address_1, :string
      t.column :address_2, :string
      t.column :city, :string
      t.column :state, :string
      t.column :zip, :integer
      t.column :phone, :string
      t.column :email, :string
      t.column :active, :integer
    end
  end

  def self.down
    drop_table :employees
  end
end
