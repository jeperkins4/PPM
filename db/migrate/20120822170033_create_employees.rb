class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.integer :facility_id
      t.string :firstname
      t.string :lastname
      t.string :emplid
      t.boolean :active
      t.string :tea_status

      t.timestamps
    end
  end
end
