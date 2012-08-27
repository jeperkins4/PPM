class AccessLevel < ActiveRecord::Base
  has_many :user_types

  attr_accessible :id, :description, :name
end
