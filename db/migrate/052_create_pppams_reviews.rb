class CreatePppamsReviews < ActiveRecord::Migration
  def self.up
    create_table :pppams_reviews do |t|
      t.column :pppams_indicator_id, :integer
      t.column :doc_count, :integer
      t.column :score , :integer
      t.column :observation_ref, :text
      t.column :documentation_ref, :text
      t.column :interview_ref, :text
      t.column :evidence, :text
      t.column :created_on, :timestamp
      t.column :updated_on, :timestamp
    end
  end

  def self.down
    drop_table :pppams_reviews
  end
end
