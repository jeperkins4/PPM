class UserType < ActiveRecord::Base
  belongs_to :access_level
  has_many :users

  attr_accessible :id, :access_level_id, :description, :name

  delegate :name, :to => :access_level, :prefix => true, :allow_nil => false
end
