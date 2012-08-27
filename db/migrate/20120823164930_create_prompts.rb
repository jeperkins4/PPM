class CreatePrompts < ActiveRecord::Migration
  def change
    create_table :prompts do |t|
      t.string :question
      t.string :description
      t.integer :context_id
      t.boolean :used_in_total
      t.boolean :active

      t.timestamps
    end
  end
end
