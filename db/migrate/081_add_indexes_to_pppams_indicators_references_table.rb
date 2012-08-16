class AddIndexesToPppamsIndicatorsReferencesTable < ActiveRecord::Migration
  def self.up
#    add_index :pppams_indicators_pppams_references, :pppams_indicator_id
#    add_index :pppams_indicators_pppams_references, :pppams_reference_id
#    add_index :pppams_indicators_pppams_references, [:pppams_indicator_id, :pppams_reference_id], :name => 'indicator_reference'
  end

  def self.down
#    remove_index :pppams_indicators_pppams_references, :pppams_indicator_id
#    remove_index :pppams_indicators_pppams_references, :pppams_reference_id
#    remove_index :pppams_indicators_pppams_references, :name => 'indicator_reference'
  end
end
