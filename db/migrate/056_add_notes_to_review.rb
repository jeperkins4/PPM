class AddNotesToReview < ActiveRecord::Migration
  def self.up
    add_column :pppams_reviews, :notes, :text
  end

  def self.down
    remove_column :pppams_reviews, :notes
  end
end
