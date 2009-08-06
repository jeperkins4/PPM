class AddIndexesToPrompts < ActiveRecord::Migration
  def self.up
    add_index :prompts, [:context_id, :used_in_total], :name => 'context_used_in_total'
  end

  def self.down
    remove_index :prompts, :name => 'context_used_in_total'
  end
end
