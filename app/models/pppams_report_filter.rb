class PppamsReportFilter < ActiveRecord::Base
  attr_accessible :category_filter, :created_by_id, :end_on, :facility_filter, :indicator_filter, :name, :report_type, :score_filter, :start_on, :status_filter, :updated_by_id
end
