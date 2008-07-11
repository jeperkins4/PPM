class RemoveIndicatorsReferenceCol < ActiveRecord::Migration
  def self.up
    remove_column :pppams_indicators, :reference
  end

  def self.down
    add_column :pppams_indicators, :reference, :string
  end
end
