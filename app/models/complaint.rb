class Complaint < ActiveRecord::Base
    belongs_to :user
    belongs_to :facility
    has_many :complaint_follow_ups


    validates_presence_of :type
    validates_presence_of :complaint_date
    validates_presence_of :received_date
    validates_presence_of :complainer_contact
    validates_presence_of :inmate_details
    validates_presence_of :description
end