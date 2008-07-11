class CreateAccessLevels < ActiveRecord::Migration
  def self.up
    create_table :access_levels do |t|
      t.column :access_level, :string
      t.column :description, :text
    end
  end

  def self.down
    drop_table :access_levels
  end
end
