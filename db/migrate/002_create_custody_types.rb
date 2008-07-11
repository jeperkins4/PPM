class CreateCustodyTypes < ActiveRecord::Migration
  def self.up
    create_table :custody_types do |t|
      t.column :custody_type, :string
      t.column :description, :text
    end
  end

  def self.down
    drop_table :custody_types
  end
end
