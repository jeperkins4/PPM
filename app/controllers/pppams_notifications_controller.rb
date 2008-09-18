class PppamsNotificationsController < ApplicationController
  before_filter :admin_authenticate
  layout 'administration'
  
  # GET /pppams_notifications
  # GET /pppams_notifications.xml
  def index
    @facilities = Facility.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @facilities.to_xml }
    end
  end

  def update_notifications
    Facility.find(:all).each do |facility|
      %w(Submitted Review Accepted Locked).each do |status|
        if params["facility_#{facility.id}_#{status}"] == "1"
          NotificationReceiver.add_receiver(User.current_user, facility, status)
        else
          NotificationReceiver.drop_receiver(User.current_user, facility, status)
        end
      end
    end

    flash[:notice] = "Changes to Report Status Notifications have been saved. Please review your selections below."
    redirect_to :action => 'index'
  end

  def update_reviews
    Facility.find(:all).each do |facility|
      (0..31).each do |n| 
        if params["facility_#{facility.id}_#{n}"] == "1"
          NotificationReport.add_offset(User.current_user, facility, n)
        else
          NotificationReport.drop_offset(User.current_user, facility, n)
        end
      end
    end

    flash[:notice] = "Review Status Notification Days have been saved. Please review your selections below."
    redirect_to :action => 'index'
  end

end
