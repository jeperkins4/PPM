class NonCompIssue < ActiveRecord::Base
  attr_accessible :cap_due_on, :cap_review_on, :conclusion, :created_by_id, :details, :discovered_on, :facility_id, :issue_number, :nci_status, :notes, :notified_on, :requirement, :resolved_on, :updated_by_id
end
