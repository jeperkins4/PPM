class AddGoodMonths < ActiveRecord::Migration
  def self.up
    add_column :pppams_indicators, :good_months, :string
  end

  def self.down
    remove_column :pppams_indicators, :good_months
  end
end