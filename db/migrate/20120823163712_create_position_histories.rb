class CreatePositionHistories < ActiveRecord::Migration
  def change
    create_table :position_histories do |t|
      t.integer :position_id
      t.decimal :salary, :precision => 10, :scale => 2

      t.timestamps
    end
  end
end
