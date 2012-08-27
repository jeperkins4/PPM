class CreateCustodyTypes < ActiveRecord::Migration
  def change
    create_table :custody_types do |t|
      t.string :name
      t.string :description

      t.timestamps
    end

    create_table :custody_types_facilities, :id => false do |t|
      t.references :custody_type, :null => false
      t.references :facility, :null => false
    end

  end
end
