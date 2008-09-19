class AddPppamsReviewSubmitCount < ActiveRecord::Migration
  def self.up
    add_column :pppams_reviews, :submit_count, :integer
  end

  def self.down
    remove_column :pppams_reviews, :submit_count
  end
end
