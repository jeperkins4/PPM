<<<<<<< HEAD
class FollowUp < ActiveRecord::Base
  attr_accessible :comment, :commented_at, :incident_id, :user_id
end
=======
class FollowUp < ActiveRecord::Base
  belongs_to :incident
end
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
