class CreatePppamsIndicatorBaseRefsPppamsReferences < ActiveRecord::Migration
  def self.up
    create_table :pppams_indicator_base_refs_pppams_references, :id => false do |t|
    t.column :pppams_indicator_base_ref_id, :integer, :null => false
    t.column :pppams_reference_id,  :integer, :null => false
end

  end

  def self.down
    drop_table :pppams_indicators_base_refs_pppams_references
  end
end
