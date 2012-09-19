class NonCompFollowUp < ActiveRecord::Base
<<<<<<< HEAD
  attr_accessible :comment, :created_by_id, :non_comp_issue_id, :updated_by_id
=======

    belongs_to :non_comp_issue

>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
end
