class NotificationReport < ActiveRecord::Base

  
  belongs_to :facility
  belongs_to :user

  validates_inclusion_of :eom_offset, :in => (0..31)

  def self.notification_users(facility_id, notification_date)
    days_in_given_month = Time.days_in_month(notification_date.month, notification_date.year)
    if notification_date.day == 1
      NotificationReport.find(:all, :conditions => {:facility_id => facility_id, :eom_offset => (days_in_given_month..31)}).map {|x| x.user}.uniq
    else
      notification_offset = days_in_given_month - notification_date.day
      NotificationReport.find(:all, :conditions => {:facility_id => facility_id, :eom_offset => notification_offset}).map {|x| x.user}.uniq
    end
  end

  def self.notification_reports(user, facility)
    NotificationReport.find(:all, :conditions => {:user_id => user.id, :facility_id => facility.id})
  end

  def self.add_offset(user, facility, eom_offset)
    keys = {:user_id => user.id, :facility_id => facility.id, :eom_offset => eom_offset}
    @receiver = NotificationReport.find(:first, :conditions => keys)
    @receiver = NotificationReport.create(keys) unless @receiver
    @receiver
  end

  def self.drop_offset(user, facility, eom_offset)
     keys = {:user_id => user.id, :facility_id => facility.id, :eom_offset => eom_offset}
     @receiver = NotificationReport.find(:first, :conditions => keys)
     return @receiver ? @receiver.destroy : false
  end

  def day_this_month
    now = Time.now
    return [Time.days_in_month(now.month, now.year) - eom_offset, 1].max
  end

  
  def self.generate_pending_review_notifications(date = Time.now, server_name = NotificationReceiver.request_env['SERVER_NAME'])
    notification_count = 0
    facilities = Facility.find(:all)
    facilities.each do |facility|

      receivers = NotificationReport.notification_users(facility, date)
      to_do_ar = PppamsIndicator.find_current_todo(date, facility)
      days_in_month = Time.days_in_month(date.month, date.year)
      days_remaining = days_in_month - date.day
      days_remaining_s = "#{days_remaining} #{days_remaining == 1 ? 'day' : 'days'} remaining"
      done = to_do_ar[0]
      all = to_do_ar[1]
      to_do = all - done

      body = [
        "Report Date||#{date.strftime("%B %d, %Y")} (#{days_remaining_s} in #{date.strftime("%B")})", 
        "Facility||#{facility.facility}",
        "Reviews Started for #{date.strftime("%B")}||#{done}",
        "Total Reviews for #{date.strftime("%B")}||#{all}",
        "Reviews Not Started for #{date.strftime("%B")}||#{to_do} (#{((to_do*100.0)/all).round rescue 0.0}%)",
        "Link||http://#{server_name}/pppams_reviews/"
      ].join("\n\n").gsub(/\|\|/,":\n  ")

      receivers.each do |receiver|

        keys = {
          :to_email => receiver.email,
          :from_email => Notification::NotificationSender,
          :subject => "[PPPAMS] #{done} of #{all} #{all == 1 ? 'Review' : 'Reviews'} " +
            "completed for #{facility.facility} with #{days_remaining_s} in #{date.strftime("%B")}",
          :status => 'Pending',
          :body => body,
          :created_by => receiver
        }
        notification_count += 1
        Notification.create(keys)
      end
    end
    notification_count
  end
  
end