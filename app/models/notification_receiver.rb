class NotificationReceiver < ActiveRecord::Base
  attr_accessible :facility_id, :status, :user_id
  
  DeliveryInterval = 20

  belongs_to :facility
  belongs_to :user

  cattr_accessor :request_env

  validates_presence_of :user_id, :facility_id, :status
  validates_inclusion_of :status, :in => %w(Submitted Review Accepted Locked), :message => "Invalid Status"
  
  def self.notification_times
    # generate times from '12:00 am' to '11:40 pm' for select options, stored in db as '1320' for '01:20 pm' 
    times = []
    minutes = [0,20,40] # based on DeliveryInterval
    (12..12).each {|h| minutes.each {|m| times << [sprintf("%02d:%02d am", h, m), sprintf("%02d%02d", 0,      m)] }}
    (1..11).each  {|h| minutes.each {|m| times << [sprintf("%02d:%02d am", h, m), sprintf("%02d%02d", h,      m)] }}
    (12..12).each {|h| minutes.each {|m| times << [sprintf("%02d:%02d pm", h, m), sprintf("%02d%02d", 12,     m)] }}
    (1..11).each  {|h| minutes.each {|m| times << [sprintf("%02d:%02d pm", h, m), sprintf("%02d%02d", 12 + h, m)] }}
    times
  end

  def self.notification_users(facility, status)
    NotificationReceiver.find(:all, :conditions => {:facility_id => facility.id, :status => status}).map {|x| x.user}.uniq
  end

  def self.add_receiver(user, facility, status)
    keys = {:user_id => user.id, :facility_id => facility.id, :status => status}
    @receiver = NotificationReceiver.find(:first, :conditions => keys)
    @receiver = NotificationReceiver.create(keys) unless @receiver
    @receiver
  end

  def self.drop_receiver(user, facility, status)
     keys = {:user_id => user.id, :facility_id => facility.id, :status => status}
     @receiver = NotificationReceiver.find(:first, :conditions => keys)
     return @receiver ? @receiver.destroy : false
  end

  def self.receives_notifications?(user, facility, status)
    keys = {:user_id => user.id, :facility_id => facility.id, :status => status}
    @receiver = NotificationReceiver.find(:first, :conditions => keys)
    return @receiver.nil? ? false : true
  end

  def self.generate_status_notifications(review)
    notification_receivers = NotificationReceiver.notification_users(review.facility, review.status)

    if review.status == 'Review'
      notification_receivers << review.created_by
    end

    notification_receivers.each do |receiver|

      message_status = case receiver.notify_method
        when 'digest' then 'Digest'
        when 'single' then 'Pending'
        else 'Pending'
      end

      body = [
        "Review ID||#{review.id}", "Review Status||#{review.status}",
        "Date||#{review.updated_on.strftime("%B %d, %Y @ %H:%m")}",
        "Facility||#{review.pppams_indicator.facility.facility}",
        "Indicator Category||#{review.pppams_indicator.pppams_indicator_base_ref.pppams_category_base_ref.name}",
        "Indicator Question||#{review.pppams_indicator.question}",
        "Link||http://#{NotificationReceiver.request_env['SERVER_NAME']}/pppams_reviews/#{review.id}"
      ].join("\n\n").gsub(/\|\|/,":\n  ")

      keys = {
        :to_email => receiver.email, 
        :from_email => Notification::NotificationSender,
        :subject => "[PPPAMS] Review #{review.id} status updated to #{review.status} on #{review.updated_month_day} by #{review.updater}",
        :status => message_status,
        :created_by => review.updated_by,
        :body =>  body
      }

      Notification.create(keys)

    end
  end 
  
  def self.prepare_digest_notifications
    digest_notifications = Notification.pending_digest_notifications
    keys = nil

    digest_notifications.group_by(&:to_email).each do |email, notifications|
      user = User.find_by_email(email)
    
      if user.nil? or user.notify_method != 'digest'
        # if the user has changed email addresses, or is no longer receiving digests,
        # convert these to Pending notifications
        notification.status = 'Pending'
        notification.save
      else
        # If the time now is less than 20 minutes after the user's notify_digest_time, then
        # merge the Digest notifications into one new Pending message, and change the 
        # Digest notifications to Merged
        now = Time.now.strftime("%H%M")
        minutes = now.to_i - user.notify_digest_time.to_i
        if minutes >= 0 and minutes < DeliveryInterval
          keys = merge_and_archive(notifications)
        end
      end
    end
    
  end

  def validate
    errors.add(:user_id, "must be an admin user") unless user.is_admin?
  end
  
  def self.merge_and_archive(notifications)
    # combined all notifications into a single new Pending message
    reviews = notifications.size == 1 ? 'Review' : 'Reviews'
    keys = {
      :to_email => notifications.first.to_email,
      :from_email => Notification::NotificationSender,
      :subject => "[PPPAMS] Status Updated for #{notifications.size} #{reviews} on #{Time.now.strftime("%B %d")}",
      :status => 'Pending',
      :created_by => notifications.first.created_by,
      :body => notifications.map {|x| x.subject.gsub(/\[PPPAMS\] /, "Summary:\n  ") + "\n\n" + x.body}.join("\n\n----------\n\n")
    }
    Notification.create(keys)
    
    # Mark each digested notification as Merged
    notifications.each do |notification|
      notification.status = 'Merged'
      notification.save
    end
    keys
  end
end
