class CreateInmateCounts < ActiveRecord::Migration
  def change
    create_table :inmate_counts do |t|
      t.integer :facility_id
      t.integer :inmate_count
      t.datetime :collected_on
      t.integer :custody_type_id

      t.timestamps
    end
  end
end
