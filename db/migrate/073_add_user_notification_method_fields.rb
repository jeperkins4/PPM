class AddUserNotificationMethodFields < ActiveRecord::Migration
  def self.up
    add_column :users, :notify_method, :string
    add_column :users, :notify_digest_time, :string
    set_default_user_notify_method
  end

  def self.down
    remove_column :users, :notify_method
    remove_column :users, :notify_digest_time
  end
 
  protected
 
  def self.set_default_user_notify_method
    User.find(:all).each do |user|
      puts "Setting the notification method of #{user.name} to 'single' ..."
      user.notify_method = 'single'
      user.save
    end
  end
end