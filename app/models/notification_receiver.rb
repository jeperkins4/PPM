class NotificationReceiver < ActiveRecord::Base

  belongs_to :facility
  belongs_to :user

  validates_presence_of :user_id, :facility_id, :status
  validates_inclusion_of :status, :in => %w(Submitted Review Accepted), :message => "Invalid Status"

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

      body = [
        "Review ID||#{review.id}", "Review Status||#{review.status}",
        "Date||#{review.updated_on.strftime("%B %d, %Y @ %H:%m")}",
        "Facility||#{review.pppams_indicator.pppams_category.facility.facility}",
        "Indicator Category||#{review.pppams_indicator.pppams_category.name}",
        "Indicator Question||#{review.pppams_indicator.question}",
        "Link||http://#{request.env['HTTP_HOST']}/pppams_reviews/#{review.id}"
      ].join("\n\n").gsub(/\|\|/,":\n  ")

      keys = {
        :to_email => receiver.email, 
        :from_email => Notification::NotificationSender,
        :subject => "[PPPAMS] Review #{review.id} status updated to #{review.status} on #{review.updated_month_day} by #{review.updater}",
        :status => "Pending",
        :created_by => review.updated_by,
        :body =>  body
      }

      Notification.create(keys)

    end
  end 


  def validate
    errors.add(:user_id, "must be an admin user") unless user.is_admin?
  end

end
