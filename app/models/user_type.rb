class UserType < ActiveRecord::Base
  has_many :users, :through => :user_type_id
  belongs_to :access_level
end
