class CreatePppamsCategories < ActiveRecord::Migration
  def self.up
    create_table :pppams_categories do |t|
      t.column :name , :string
      t.column :description, :text
    end
  end

  def self.down
    drop_table :pppams_categories
  end
end
