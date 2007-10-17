class AddColumnTeaStatusToEmployee < ActiveRecord::Migration
 def self.up
    add_column :employees, :tea_status, :string
  end
  
  def self.down
   remove_column :employees, :tea_status
  end
end
