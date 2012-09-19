class Notification < ActiveRecord::Base
  attr_accessible :message, :recipient, :sender, :status, :subject, :user_id
end
