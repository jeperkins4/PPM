class FollowUp < ActiveRecord::Base
  belongs_to :incident
  attr_accessible :comment, :commented_at, :incident_id, :user_id
end
