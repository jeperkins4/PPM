class Upload < ActiveRecord::Base
  attr_accessible :name, :uploadable_id, :uploadable_type, :user_id
end
