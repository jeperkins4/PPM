class CreatePppamsReviews < ActiveRecord::Migration
  def change
    create_table :pppams_reviews do |t|
      t.integer :pppams_indicator_id
      t.integer :doc_count
      t.integer :score
      t.string :observation_ref
      t.string :documentation_ref
      t.string :interview_ref
      t.string :status
      t.text :notes
      t.integer :created_by_id
      t.integer :updated_by_id
      t.integer :submit_count
      t.datetime :real_creation_on

      t.timestamps
    end
  end
end
