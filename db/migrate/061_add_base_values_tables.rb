class AddBaseValuesTables < ActiveRecord::Migration
  def self.up
    create_table :pppams_category_base_refs do |t|
      t.column :name, :string
    end

    create_table :pppams_indicator_base_refs do |t|
      t.column :question, :text
    end

  end



  def self.down
    drop_table :pppams_category_base_refs
    drop_table :pppams_indicator_base_refs
  end
end

