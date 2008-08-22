class Notification < ActiveRecord::Base
  
  NotificationSender = 'notifications@dms.myflorida.com'
  RegexEmail = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  belongs_to :user, :foreign_key => "created_by"

  validates_presence_of :to_email, :from_email, :subject, :body, :status, :created_by
  validates_format_of :to_email, :with => RegexEmail
  validates_format_of :from_email, :with => RegexEmail
  validates_inclusion_of :status, :in => %w(Pending Sent Error), :message => "Invalid Status"

  def self.pending_notifications
    Notification.find(:all, :conditions => {:status => 'Pending'}, :order => 'updated_at')
  end

  def self.purge_notifications(status, days_old)
    @purgable_notifications = Notification.find(:all, :conditions => ["status = ? and created_at < ?", status, days_old.days.ago])
    @purgable_notifications.each do |notification|
      notification.destroy
    end
  end

  def deliver_notification
    begin
      Notifier.deliver_notification(self)
      self.status = "Sent"
      self.save
    rescue Exception => e
      self.status = "Error"
      self.save
    end
  end

end
