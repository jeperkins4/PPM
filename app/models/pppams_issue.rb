class PppamsIssue < ActiveRecord::Base
  belongs_to :user
  belongs_to :facility
  has_many :pppams_issue_follow_ups

  validates_presence_of :received_date
  validates_presence_of :description

  before_save :set_pppams_issue_status

  attr_accessible :category, :cm_response_due_on, :cm_response_on, :created_by_id, :description, :facility_id, :inmate_details, :inmate_id, :pppams_issue_id, :pppams_issue_number, :pppams_issue_status, :received_on, :receiver, :reported_by, :resolved_on, :updated_by_id

  def set_pppams_issue_status
    if self.received_date.nil?
      self.pppams_issue_status =  0
    elsif self.CM_response_due_date.nil?
      self.pppams_issue_status =  1
    elsif self.CM_response_date.nil?
      self.pppams_issue_status =  2
    else 
      self.pppams_issue_status =  3
    end
  end

  def self.categories
    ['Complaint', 'Inmate Complaint','Contract File Note','Vendor/Lobbyist Correspondence','Telephone Inquiry','DMS Inquiry','From DMS Communication','Dept. Of Corrections Note','PPPAMS','Medical','Strategic Goals','Annual Report Information','IWTF','MMRF','General Note','Other'].sort
  end
end
