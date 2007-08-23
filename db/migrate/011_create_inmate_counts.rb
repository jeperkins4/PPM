class CreateInmateCounts < ActiveRecord::Migration
  def self.up
    create_table :inmate_counts do |t|
      t.column :facility_id, :integer
      t.column :inmate_count, :integer
      t.column :date_collected, :date
    end
  end

  def self.down
    drop_table :inmate_counts
  end
end
