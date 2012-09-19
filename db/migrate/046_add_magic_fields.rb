class AddMagicFields < ActiveRecord::Migration
  def self.up
    add_column :pppams_categories, :created_on, :timestamp
    add_column :pppams_indicators, :created_on, :timestamp
    add_column :pppams_categories, :updated_on, :timestamp
    add_column :pppams_indicators, :updated_on, :timestamp
  end

  def self.down
    remove_column :pppams_categories, :created_on
    remove_column :pppams_indicators, :created_on
    remove_column :pppams_categories, :updated_on
    remove_column :pppams_indicators, :updated_on
  end
end
