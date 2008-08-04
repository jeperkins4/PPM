class PppamsReviewsController < ApplicationController
  before_filter :authenticate, :set_status_ar

  layout 'administration'

  def set_status_ar
    @status_access = {'Web Developer' => ['', 'Review','Accepted'], 'Administrator' => ['', 'Review','Accepted'], 'God' => ['', 'Review','Accepted','Locked'], 'Contract Manager' => [''] }
    $cur_user_type =  User.current_user.user_type.user_type
    @status_ar = @status_access[$cur_user_type]
  end
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @pppams_review_pages, @pppams_reviews = paginate :pppams_reviews, :per_page => 10
  end

  def show
    @pppams_review = PppamsReview.find(params[:id])
  end

  def new
    @pppams_review = PppamsReview.new(:pppams_indicator_id => params[:pppams_indicator_id])
    @pppams_indicator = PppamsIndicator.find(params[:pppams_indicator_id])
    @new = true
  end

  def create
    working_date = session[:working_date]
    if working_date.month != Time.now.month or  working_date.year != Time.now.year 
	params[:pppams_review][:created_on] = DateTime.parse(working_date.month.to_s + "/" + working_date.end_of_month.day.to_s + "/" + working_date.year.to_s + " 23:59:59")
    end
    @pppams_review = PppamsReview.new(params[:pppams_review])
    if @pppams_review.save
      for this_upload in Upload.find(:all, :conditions => ["created_by = ? AND pppams_review_id is null", session[:user_id]])
        this_upload.pppams_review_id= @pppams_review.id
        this_upload.created_by= nil
        this_upload.save
      end
      flash[:notice] = 'PppamsReview was successfully created.'
      redirect_to :controller => 'pppams_indicators'
    else
      @pppams_indicator = @pppams_review.pppams_indicator
      @new = true
      render :action => 'new', :id => @pppams_review.pppams_indicator_id
    end
  end

  def edit
    @pppams_review = PppamsReview.find(params[:id])
    if !@pppams_review.can_edit?
      flash[:notice] = 'You do not have permission to edit this review! Please contact an administrator!'
      redirect_to :controller => 'pppams_indicators'
      break
    end
    @pppams_indicator = @pppams_review.pppams_indicator
    @new = false
  end

  def update
    @pppams_review = PppamsReview.find(params[:id])
    if @pppams_review.update_attributes(params[:pppams_review])
      for this_upload in Upload.find(:all, :conditions => ["created_by = ? AND pppams_review_id is null", session[:user_id]])
        this_upload.pppams_review_id=@pppams_review.id
        this_upload.created_by=nil
        this_upload.save
      end
      flash[:notice] = 'PppamsReview was successfully updated.'
      redirect_to :controller => 'pppams_indicators'
    else
      render :action => 'edit'
    end
  end

  def destroy
    PppamsReview.find(params[:id]).destroy
    redirect_to :controller => 'pppams_indicators'
  end
  
  def trash_upload
    Upload.find(params[:upload]).destroy
    render :update do |page|
      page.replace_html "uploaded_file_#{upload_id}", ""
    end
  end

end
