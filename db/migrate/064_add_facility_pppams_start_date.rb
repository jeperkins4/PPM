class AddFacilityPppamsStartDate < ActiveRecord::Migration
  def self.up
    add_column :facilities, :pppams_started_on, :datetime
  end

  def self.down
    remove_column :facilities, :pppams_started_on
  end
end
