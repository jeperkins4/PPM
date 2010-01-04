require 'digest/sha1'

class User < ActiveRecord::Base
  
  belongs_to :user_type
  belongs_to :facility
  has_many :notifications, :foreign_key => "created_by"
  has_many :notification_receivers, :dependent => :destroy
  has_many :notification_reports
  has_many :pppams_issues

  validates_presence_of  :name
  validates_uniqueness_of :name
  
  attr_accessor :password_confirmation
  cattr_accessor :current_user
  attr_accessor :recently_forgot

  validates_confirmation_of :password
  
  def validate
    errors.add_to_base("Missing password") if hashed_password.blank?
  end
  
  def self.authenticate(name, password)
    user = self.find_by_name(name)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password || user.inactive_on
        user = nil
      end
    end
    user
  end
  
  def password
    @password
  end
  
  def password=(pwd)
    @password = pwd
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end
  
  def after_destroy
    if User.count.zero?
      raise "Can't delete last user"
    end
  end
  
  def is_admin?
    return true if self.user_type.access_level_id == 1
    return false
  end
  
  def forgot_password
    @recently_forgot = true
    self.make_password_reset_code
  end
  def recently_forgot_password?
    @recently_forgot
  end

protected

  def make_password_reset_code
    self.password_reset_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
  end
  
  private
  
  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt # 'wibble' makes it harder to guess
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def full_name 
    "#{self.firstname} #{self.lastname}"
  end
  
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
end
