class AddAddedByToFollowUps < ActiveRecord::Migration
   def self.up
    add_column :follow_ups, :added_by, :string
  end

  def self.down
    remove_column :follow_ups, :added_by
  end
end
