class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  include SentientController

  protected
  def authenticate
    unless request.format.html? || request.xml_http_request? || request.format.ics? || request.format.rss? || request.format.atom? || request.fullpath.include?('sitemaps')

      authenticate_or_request_with_http_basic do |username, password|
        user = User.find_all_by_authentication_token(username).first
        #if user.present?
          #account = Account.find_all_by_api_key(password).first
          #if account.present?
          #  username == user.authentication_token && password == account.api_key
          #end
        #end
      end
      warden.custom_failure! if performed?
    end
  end
end
