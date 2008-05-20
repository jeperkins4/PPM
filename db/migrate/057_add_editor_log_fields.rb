class AddEditorLogFields < ActiveRecord::Migration
  def self.up
    add_column :pppams_reviews, :created_by, :integer
    add_column :pppams_reviews, :updated, :integer
  end

  def self.down
    remove_column :pppams_reviews, :created_by
    remove_column :pppams_reviews, :updated_by
  end
end
