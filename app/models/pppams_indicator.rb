class PppamsIndicator < ActiveRecord::Base
  attr_accessible :active_on, :facility_id, :frequency, :good_months, :inactive_on, :pppams_indicator_base_ref_id, :start_month
end
