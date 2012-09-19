class AddIndexesToPppamsReviews < ActiveRecord::Migration
  def self.up
    add_index :pppams_reviews, :pppams_indicator_id
    add_index :pppams_reviews, :created_on
    add_index :pppams_reviews, [:created_on,:pppams_indicator_id]
  end

  def self.down
    remove_index :pppams_reviews, :pppams_indicator_id               
    remove_index :pppams_reviews, :created_on                        
    remove_index :pppams_reviews, [:created_on,:pppams_indicator_id] 
    
  end
end
