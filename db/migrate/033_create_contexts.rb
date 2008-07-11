class CreateContexts < ActiveRecord::Migration
  def self.up
    create_table :contexts do |t|
      t.column :title, :string
      t.column :description, :text
    end
  end

  def self.down
    drop_table :contexts
  end
end
