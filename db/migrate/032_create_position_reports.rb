class CreatePositionReports < ActiveRecord::Migration
  def self.up
    create_table :position_reports do |t|
    end
  end

  def self.down
    drop_table :position_reports
  end
end
