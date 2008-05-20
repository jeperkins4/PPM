class AddReviewStatus < ActiveRecord::Migration
  def self.up
    add_column :pppams_reviews, :status, :string
  end

  def self.down
    remove_column :pppams_reviews, :status
  end
end
