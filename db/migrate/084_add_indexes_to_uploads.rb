class AddIndexesToUploads < ActiveRecord::Migration
  def self.up
    add_index :uploads, [:created_by, :pppams_review_id], :name => 'created_by_pppams_review_id'
  end

  def self.down
    remove_index :uploads, :name => 'created_by_pppams_review_id'
  end
end
