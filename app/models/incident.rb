class Incident < ActiveRecord::Base
  belongs_to :facility
  belongs_to :incident_type
  belongs_to :incident_class
  belongs_to :action_type
  has_many :follow_ups
end
