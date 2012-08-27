class CreateInvestigators < ActiveRecord::Migration
  def change
    create_table :investigators do |t|
      t.string :firstname
      t.string :lastname
      t.string :phone
      t.string :email
      t.string :entity
      t.integer :facility_id

      t.timestamps
    end
  end
end
