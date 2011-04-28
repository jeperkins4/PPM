class UserType < ActiveRecord::Base
  belongs_to :access_level

  def self.administrator
    find_by_user_type('Administrator')
  end
  def self.web_developer
    find_by_user_type('Web Developer')
  end
  def self.contract_manager
    find_by_user_type('Contract Manager')
  end
  def self.super_administrator
    find_by_user_type('SuperAdministrator')
  end
end
