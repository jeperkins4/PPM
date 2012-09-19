class AddIndexesToPppamsIndicators < ActiveRecord::Migration
  def self.up
    add_index :pppams_indicators, :pppams_category_id, :name => 'pppams_category_id'
    add_index :pppams_indicators, :pppams_indicator_base_ref_id, :name => 'pppams_indicator_base_ref_id'
    PppamsIndicator.connection.execute('CREATE INDEX good_months ON pppams_indicators (good_months(4));')
    PppamsIndicator.connection.execute('CREATE INDEX category_good_months ON pppams_indicators (pppams_category_id, good_months(4));')
  
  end

  def self.down
    remove_index :pppams_indicators, :name => 'pppams_category_id'
    remove_index :pppams_indicators, :name => 'pppams_indicator_base_ref_id'
    remove_index :pppams_indicators, :name => 'good_months'
    remove_index :pppams_indicators, :name => 'category_good_months'
    
  end
end
