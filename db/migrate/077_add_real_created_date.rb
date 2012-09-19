class AddRealCreatedDate < ActiveRecord::Migration
  def self.up
    add_column :pppams_reviews, :real_creation_date, :datetime
  end

  def self.down
    remove_column :pppams_reviews, :real_creation_date
  end
end
