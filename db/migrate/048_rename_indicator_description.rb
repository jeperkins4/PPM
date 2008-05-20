class RenameIndicatorDescription < ActiveRecord::Migration
  def self.up
      rename_column :pppams_indicators, :description, :question
  end

  def self.down
      rename_column :pppams_indicators, :question, :description
  end
end
