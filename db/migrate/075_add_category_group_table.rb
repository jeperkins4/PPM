class AddCategoryGroupTable < ActiveRecord::Migration
  def self.up
    add_column :pppams_category_base_refs, :pppams_category_group_id, :integer
    create_table :pppams_category_groups do |t|
      t.column :name, :string
    end
  end

  def self.down
    remove_column :pppams_category_base_refs, :pppams_category_group_id
    drop_table :pppams_category_groups 
  end
  
end
