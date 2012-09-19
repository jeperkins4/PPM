class AddInactiveOnToPppamsIndicators < ActiveRecord::Migration
  def self.up
    add_column :pppams_indicators, :inactive_on, :date
  end

  def self.down
    remove_column :pppams_indicators, :inactive_on
  end
end
