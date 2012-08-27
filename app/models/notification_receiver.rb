class NotificationReceiver < ActiveRecord::Base
  attr_accessible :facility_id, :status, :user_id
end
