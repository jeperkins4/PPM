class CreatePppamsReferencesTable < ActiveRecord::Migration
  def self.up
    create_table :pppams_references do |t|
      t.column :name, :string
      t.column :url, :string
      t.column :created_on, :datetime
      t.column :updated_on, :datetime
    end
  end

  def self.down
    drop_table :pppams_references
  end
end
