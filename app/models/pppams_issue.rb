class PppamsIssue < ActiveRecord::Base
  attr_accessible :category, :cm_response_due_on, :cm_response_on, :created_by_id, :description, :facility_id, :inmate_details, :inmate_id, :pppams_issue_id, :pppams_issue_number, :pppams_issue_status, :received_on, :receiver, :reported_by, :resolved_on, :updated_by_id
end
