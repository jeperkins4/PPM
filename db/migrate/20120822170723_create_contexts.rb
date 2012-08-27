class CreateContexts < ActiveRecord::Migration
  def change
    create_table :contexts do |t|
      t.string :title
      t.string :description
      t.integer :position

      t.timestamps
    end
  end
end
