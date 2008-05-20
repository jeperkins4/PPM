class RemoveRatingAndScoreCols < ActiveRecord::Migration
  def self.up
      remove_column :pppams_indicators, :indicator_rating
      remove_column :pppams_indicators, :max_score
  end

  def self.down
      add_column :pppams_indicators, :indicator_rating , :string
      add_column :pppams_indicators, :max_score , :integer
  end
end
