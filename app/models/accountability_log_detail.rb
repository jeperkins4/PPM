class AccountabilityLogDetail < ActiveRecord::Base
  belongs_to :facility
  belongs_to :context

  attr_accessible :context_id, :detail_response, :facility_id, :log_month, :log_year, :logged_at
end
