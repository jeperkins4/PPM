class NonCompFollowUp < ActiveRecord::Base
  belongs_to :non_comp_issue
  attr_accessible :comment, :created_by_id, :non_comp_issue_id, :updated_by_id
end
