class NonCompIssue < ActiveRecord::Base
    belongs_to :facility
    has_many :non_comp_follow_ups
    has_many :uploads, :as => :uploadable

    validates_presence_of :discovery_date
    validates_presence_of :facility_id
    validates_presence_of :details
    validates_presence_of :requirement
    validates_presence_of :notification_date, :if => :is_resolved?
    validates_presence_of :cap_due_date, :if => :is_resolved?
    validates_presence_of :cap_review_date, :if => :is_resolved?

    before_save :set_nci_status
    
    def is_resolved?
      !resolved_date.nil?
    end

    def set_nci_status
      if self.notification_date.nil?
        self.nci_status =  0
      elsif self.cap_due_date.nil?
        self.nci_status =  1
      elsif self.cap_review_date.nil?
        self.nci_status =  2
      elsif self.resolved_date.nil?
        self.nci_status =  3
      else 
        self.nci_status =  4
      end
    end


end
