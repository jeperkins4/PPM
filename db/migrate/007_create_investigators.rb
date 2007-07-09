class CreateInvestigators < ActiveRecord::Migration
  def self.up
    create_table :investigators do |t|
      t.column :firstname, :string
      t.column :lastname, :string
      t.column :phone, :string
      t.column :email, :string
      t.column :entity, :string
      t.column :facility_id, :integer
    end
  end

  def self.down
    drop_table :investigators
  end
end
