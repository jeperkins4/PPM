<<<<<<< HEAD
class PppamsReviewsController < ApplicationController
  # GET /pppams_reviews
  # GET /pppams_reviews.json
  def index
    @pppams_reviews = PppamsReview.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pppams_reviews }
    end
  end

  # GET /pppams_reviews/1
  # GET /pppams_reviews/1.json
  def show
    @pppams_review = PppamsReview.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pppams_review }
    end
  end

  # GET /pppams_reviews/new
  # GET /pppams_reviews/new.json
  def new
    @pppams_review = PppamsReview.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pppams_review }
    end
  end

  # GET /pppams_reviews/1/edit
  def edit
    @pppams_review = PppamsReview.find(params[:id])
  end

  # POST /pppams_reviews
  # POST /pppams_reviews.json
  def create
    @pppams_review = PppamsReview.new(params[:pppams_review])

    respond_to do |format|
      if @pppams_review.save
        format.html { redirect_to @pppams_review, notice: 'Pppams review was successfully created.' }
        format.json { render json: @pppams_review, status: :created, location: @pppams_review }
      else
        format.html { render action: "new" }
        format.json { render json: @pppams_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pppams_reviews/1
  # PUT /pppams_reviews/1.json
  def update
    @pppams_review = PppamsReview.find(params[:id])

    respond_to do |format|
      if @pppams_review.update_attributes(params[:pppams_review])
        format.html { redirect_to @pppams_review, notice: 'Pppams review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pppams_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pppams_reviews/1
  # DELETE /pppams_reviews/1.json
  def destroy
    @pppams_review = PppamsReview.find(params[:id])
    @pppams_review.destroy

    respond_to do |format|
      format.html { redirect_to pppams_reviews_url }
      format.json { head :no_content }
    end
  end
end
=======
class PppamsReviewsController < ApplicationController
  before_filter :authenticate, :set_status_ar

  layout 'administration'

  def set_status_ar
    @status_access = {'Web Developer' => ['', 'Review','Accepted'],
                      'Administrator' => ['', 'Review','Accepted'],
                      'SuperAdministrator' => ['', 'Review','Accepted','Locked'],
                      'Contract Manager' => [''] }
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
    @pppams_reviews = PppamsReview.paginate :page => params[:page]
  end

  def show
    @pppams_review = PppamsReview.find(params[:id])
  end

  def new
    @pppams_review = PppamsReview.new(params[:pppams_review])
    @pppams_indicator = PppamsIndicator.find(params[:pppams_review][:pppams_indicator_id])
    @new = true
  end

  def create
    working_date = session[:working_date]
    if working_date.month != Time.now.month or  working_date.year != Time.now.year
      params[:pppams_review][:created_on] = DateTime.parse(working_date.month.to_s + "/" + working_date.end_of_month.day.to_s + "/" + working_date.year.to_s + " 23:59:59")
      params[:pppams_review][:real_creation_date] = Time.now
    end
    done = PppamsReview.find(:all, :conditions => ["created_on >= ? and created_on <= ? and pppams_indicator_id = ?", working_date.beginning_of_month, DateTime.parse(working_date.month.to_s + "/" + working_date.end_of_month.day.to_s + "/" + working_date.year.to_s + " 23:59:59"), params[:pppams_review][:pppams_indicator_id]])
    if done.length > 0
      flash[:notice] = 'A review already exists for this indicator this month! Please edit the current indicator rather than create a new one.'
      redirect_to :controller => 'pppams_indicators'
    else
      @pppams_review = PppamsReview.new(params[:pppams_review])
      if @pppams_review.save
        save_uploads(@pppams_review)
        flash[:notice] = 'Pppams Review was successfully created.'
        redirect_to :controller => 'pppams_indicators'
      else
        @pppams_indicator = @pppams_review.pppams_indicator
        @new = true
        render :action => 'new', :id => @pppams_review.pppams_indicator_id
      end
    end
  end

  def edit
    @pppams_review = PppamsReview.find(params[:id])
    if !@pppams_review.can_edit?
      flash[:notice] = 'You do not have permission to edit this review! Please contact an administrator!'
      redirect_to :controller => 'pppams_indicators'
      return
    end
    @pppams_indicator = @pppams_review.pppams_indicator
    @new = false
  end

  def update
    @pppams_review = PppamsReview.find(params[:id])
    if @pppams_review.update_attributes(params[:pppams_review])
      save_uploads(@pppams_review)
      flash[:notice] = 'Pppams Review was successfully updated.'
      redirect_to :controller => 'pppams_indicators'
    else
      @pppams_indicator = @pppams_review.pppams_indicator
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
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
