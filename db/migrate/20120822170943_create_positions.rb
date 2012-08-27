class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :title
      t.integer :position_type_id
      t.decimal :salary, :precision => 10, :scale => 2
      t.string :description

      t.timestamps
    end
  end
end
