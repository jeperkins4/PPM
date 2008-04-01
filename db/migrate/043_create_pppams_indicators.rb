class CreatePppamsIndicators < ActiveRecord::Migration
  def self.up
    create_table :pppams_indicators do |t|
      t.column :pppams_category_id, :integer
      t.column :description, :text
      t.column :reference , :string
      t.column :frequency, :integer
      t.column :indicator_rating , :string
      t.column :max_score , :integer
      t.column :start_month, :integer
    end
  end

  def self.down
    drop_table :pppams_indicators
  end
end
