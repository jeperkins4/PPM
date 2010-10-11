class AddUploadableTypeToUploads < ActiveRecord::Migration
  def self.up
    add_column :uploads, :uploadable_type, :string
    rename_column :uploads, :pppams_review_id, :uploadable_id
  end

  def self.down
    remove_column :uploads, :uploadable_type
    rename_column :uploads, :uploadable_id, :pppams_review_id
  end
end
