class AccountabilityLog < ActiveRecord::Base
  belongs_to :facility
  belongs_to :prompt

  attr_accessible :context_id, :facility_id, :log_month, :log_year, :logged_at, :prompt_id, :response
end
