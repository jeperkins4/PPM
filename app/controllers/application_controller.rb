<<<<<<< HEAD
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
=======
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ExceptionNotifiable

  before_filter :set_page
  before_filter :set_facility, :except => ''

  #AJR Added switch statement to proceed with updates to production while PPPAMS module is still being tested.
  #This code will automatically start loading when the new module is uploaded to production
  # and will continue to function in development where the files currently exist
  if File.exist?("#{RAILS_ROOT}/lib/custom_funcs.rb") then
    before_filter do |c|
      User.current_user = User.find_by_id(c.session[:user_id])
      NotificationReceiver.request_env = c.request.env
    end
    after_filter :clean_up_uploads, :except => ['update', 'create', 'trash_upload', 'uploadFile']
    include DebugHelper
    $LOAD_PATH.unshift 'vendor/plugins/responds_to_parent/lib'
    $LOAD_PATH.unshift 'vendor/plugins/orderedhash/lib'
    $LOAD_PATH.unshift 'vendor/plugins/fastercsv/lib'
    $LOAD_PATH.unshift 'vendor/plugins/calendar_date_select/lib'
    $LOAD_PATH.unshift 'vendor/plugins/multiple_select/lib'
    require 'custom_funcs'
  end

  def admin_authenticate
    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
      unless @user.user_type.access_level.id == 1
        flash[:notice]="You are not authorized to view this area."
        redirect_to(:controller => "login", :action => "index")
      end
    else
      flash[:notice]="Please log in."
      redirect_to(:controller => "login", :action => "index")
    end
  end

  def authenticate
    puts User.all.map(&:id).join(',') unless session[:user_id].present?
    unless @user = User.find_by_id(session[:user_id])
      flash[:notice]="Please log in."
      redirect_to(:controller => "login", :action => "index")
    end
  end

  def set_facility
    if ["reports", "non_comp_issues", "pppams_issues"].index(params[:controller]).nil? && session[:facility].class.to_s == 'Junk'
      session[:facility] = ''
      params[:set_facility] = {:facility_id => ''} if params[:set_facility].nil?
    end

    if session[:access_level] == 'Administrator'
      unless params[:set_facility]
        unless session[:facility]
          @page_check = 0
          @page_check2 = 0
          ['facilities',
            'users',
            'custody_types',
            'action_types',
            'access_levels',
            'user_types',
            'login',
            'incident_types',
            'position_types',
            'incident_classes',
            'reset_password',
            'contexts',
            'prompts',
            'pppams_category_base_refs',
            'pppams_indicator_base_refs',
            'pppams_indicators',
            'pppams_notifications'].each do |page_check|
            request.request_uri.split('/').each do |page|
              page.split('?').each do |page2|
                if page2.to_s == page_check
                  @page_check += 1
                end
              end
            end
          end

          if @page_check == 0
            render :text => "Please select a facility from the drop down above to continue.", :layout => true
          end
        end
      else
        if params[:set_facility][:facility_id] == "-1"
          session[:facility] = Junk.new
          redirect_to(:controller => request.request_uri.split('/'), :action => 'index')
        elsif params[:set_facility][:facility_id] != ""
          session[:facility] = Facility.find(params[:set_facility][:facility_id])
          redirect_to(:controller => request.request_uri.split('/'), :action => 'index')
        else
          session[:facility] = nil
          ask_for_a_facility
        end
      end
    end
  end

  def ask_for_a_facility
    render :text => "Please select a facility from the drop down above to continue.", :layout => true
  end

  def set_page
    @host = request.host
    @page = request.request_uri.split('?')
  end

  def clean_up_uploads
    for this_upload in Upload.find(:all, :conditions => ["created_by = ? AND uploadable_id is null", session[:user_id]])
      this_upload.destroy
    end
  end

  def accountability_report
    if params[:menu] == 'Yes' then
      render :update do |page|
        page.replace_html "daterange", :partial => '/reports/date_range'
      end
    else
      render :update do |page|
        page.replace_html "daterange", :text => ""
      end
    end
  end

  def setup_session(user)
    unless user.nil?
      session[:user_id] = user.id
      session[:user] = [user.firstname,user.lastname].join(" ")
      session[:user_type] = user.user_type.user_type
      session[:name] = user.name
      session[:access_level] = user.user_type.access_level.access_level
      session[:facility] = user.facility
      yield if block_given?
    else
      flash[:notice] = "Invalid user/password combination"
    end
  end

  def require_facility
    unless session[:facility]
      ask_for_a_facility and return
    end
  end

  def save_uploads(polymorphic_parent)
    for this_upload in Upload.find(:all,
                                   :conditions => ["created_by = ? AND uploadable_id is null AND uploadable_type = '#{polymorphic_parent.class.name}'",
                                     session[:user_id]]
                                  )
      this_upload.uploadable_id=polymorphic_parent.id
      this_upload.created_by=nil
      this_upload.save
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end
end
