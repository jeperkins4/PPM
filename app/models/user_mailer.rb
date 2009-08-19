class UserMailer < ActionMailer::Base

  def forgot_password(user)
    setup_email(user)
    domain_name = APP_CONFIG['domain']
    @subject    += 'Password reset'
    @body[:url]  = 'http://'+domain_name+'/reset_password/'+user.password_reset_code 
    @recently_forgot = false
  end
  
  protected
  
  def setup_email(user)
    recipients "#{user.email}"
    from       APP_CONFIG['support_email']
    subject    "[Private Prisons] "
    body       :user => user
    sent_on    Time.now
  end

end
