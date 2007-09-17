class CreatePrompts < ActiveRecord::Migration
  def self.up
    create_table :prompts do |t|
      t.column :question, :string
      t.column :description, :text
      t.column :context_id, :integer
      t.column :used_in_total, :integer
      t.column :active, :integer
    end
  end

  def self.down
    drop_table :prompts
  end
end
