class PppamsIssueFollowUp < ActiveRecord::Base
<<<<<<< HEAD
  attr_accessible :comment, :created_by_id, :pppams_issue_id, :updated_by_id
=======

    belongs_to :pppams_issue

>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
end
