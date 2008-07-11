class CreateActionTypes < ActiveRecord::Migration
  def self.up
    create_table :action_types do |t|
      t.column :action, :string
      t.column :description, :text
    end
  end

  def self.down
    drop_table :action_types
  end
end