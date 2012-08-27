class CreatePppamsIndicators < ActiveRecord::Migration
  def change
    create_table :pppams_indicators do |t|
      t.integer :frequency
      t.integer :start_month
      t.string :good_months
      t.integer :pppams_indicator_base_ref_id
      t.date :inactive_on
      t.integer :facility_id
      t.date :active_on

      t.timestamps
    end
  end
end
