class CreatePositionTypes < ActiveRecord::Migration
  def self.up
    create_table :position_types do |t|
      t.column :position_type, :string
      t.column :description, :text
      t.column :deductable , :integer
    end
  end

  def self.down
    drop_table :position_types
  end
end
