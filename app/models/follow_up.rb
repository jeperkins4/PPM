class FollowUp < ActiveRecord::Base
  attr_accessible :comment, :commented_at, :incident_id, :user_id
end
