class Complaint < ActiveRecord::Base
    belongs_to :user
    belongs_to :facility
    has_many :complaint_follow_ups

    validates_presence_of :received_date
    validates_presence_of :complainer_contact
    validates_presence_of :inmate_details
    validates_presence_of :description

    after_save :set_complaint_status

  
  def set_complaint_status
    if self.received_date.nil?
      self.complaint_status =  0
    elsif self.CM_response_due_date.nil?
      self.complaint_status =  1
    elsif self.CM_response_date.nil?
      self.complaint_status =  2
    else 
      self.complaint_status =  3
    end
    self.update_without_callbacks
  end

end