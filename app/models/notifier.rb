class Notifier < ActionMailer::Base

  def notification(notification)
    recipients notification.to_email
    from notification.from_email
    subject notification.subject
    body :body => notification.body
  end

end
