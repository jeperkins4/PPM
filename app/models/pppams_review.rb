class PppamsReview < ActiveRecord::Base
  
    include Userstamped
    
    belongs_to :pppams_indicator
    has_many :uploads
    validates_presence_of [:score, :observation_ref, :documentation_ref, :interview_ref]
    validates_presence_of [:evidence], :if => :justify_score?
    belongs_to :created_by, :class_name => "User", :foreign_key => "created_by"
    belongs_to :updated_by, :class_name => "User", :foreign_key => "updated_by"

    before_save :update_submit_count
    after_save :generate_status_notifications

    delegate :facility, :to => :pppams_indicator

    def self.earliest
      PppamsReview.find(:all).nil? ? PppamsReview.find(:first, :order =>  "created_on ASC").created_on.year : Time.now.year
    end

    def self.latest
      PppamsReview.find(:all).nil? ? PppamsReview.find(:first, :order =>  "created_on DESC").created_on.year : Time.now.year
    end

    def generate_status_notifications
      NotificationReceiver.generate_status_notifications(self)
    end

    def justify_score?
       [7,8].index(score).nil?
    end

    def self.status_text(status_field)
      status_field.blank? ? "Submitted" : status_field
    end

    def status_text
      self.class.status_text(self.status)
    end

    def category
      pppams_indicator.pppams_category_base_ref
    end

    def updated_month_day
      updated_on.strftime("%B %d") rescue created_on.strftime("%B %d")
    end

    def updater
      if updated_by
        "#{updated_by.firstname} #{updated_by.lastname}"
      elsif created_by
        "#{created_by.firstname} #{created_by.lastname}"
      else
        "(Unknown)"
      end
    end

    def self.can_edit?(review) 
       review = find(review) unless review.class == self
       this_user_type = User.current_user.user_type
	     access_level = this_user_type.access_level.id
       if !["", "Submitted", "Review"].index(review.status).nil? or this_user_type.user_type == "SuperAdministrator" 
	    return true
	    break
       end 
       if access_level == 1 and review.status != "Locked"
	    return true
	    break
       end
       return false
    end
    
    def can_edit?
      self.class.can_edit?(self)
    end

    def update_submit_count
      # Note: 'status_changed?' method requires ActiveRecord::Dirty from Rails 2.x
      # if the status has been changed and is being set to 'Submitted'
      if self.status_changed? and self.status_text == 'Submitted'
        if self.new_record?
          # set submit_count to zero if this is a new record
          self.submit_count = 0
        else
          # if nil, assume record has been submitted once. otherwise, increment the submit count
          self.submit_count = self.submit_count.nil? ? 1 : self.submit_count + 1
        end
      end
    end
    
    def submitted_count
      submit_count.nil? ? 0 : submit_count
    end
  
    def status_display_text
      if self.status == '' or self.status == 'Submitted'
        case self.submitted_count
          when 0 then 'Submitted'
          when 1 then 'Resubmitted'
          else "Resubmitted (#{self.submit_count} times)"
        end
      else 
        self.status
      end
    end
    
end
