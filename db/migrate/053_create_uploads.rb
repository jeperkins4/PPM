class CreateUploads < ActiveRecord::Migration
  def self.up
    create_table :uploads do |t|
      t.column :pppams_review_id, :integer
      t.column :size, :integer
      t.column :file_type, :string
      t.column :name, :string
      t.column :created_on, :timestamp
      t.column :updated_on, :timestamp
      t.column :created_by, :integer
    end
  end

  def self.down
    drop_table :uploads
  end
end
