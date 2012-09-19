class AddPositionToCategories < ActiveRecord::Migration
  def self.up
     add_column :contexts, :position, :integer
  end

  def self.down
     remove_column :contexts, :position
  end
end
