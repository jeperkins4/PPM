class CreateInmates < ActiveRecord::Migration
  def self.up
    create_table :inmates do |t|
      t.column :facility_id, :integer
      t.column :inmate_count, :integer
      t.column :date_collected, :date
    end
  end

  def self.down
    drop_table :inmates
  end
end
