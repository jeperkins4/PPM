<<<<<<< HEAD
class UploadsController < ApplicationController
  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = Upload.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @uploads }
    end
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
    @upload = Upload.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @upload }
    end
  end

  # GET /uploads/new
  # GET /uploads/new.json
  def new
    @upload = Upload.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @upload }
    end
  end

  # GET /uploads/1/edit
  def edit
    @upload = Upload.find(params[:id])
  end

  # POST /uploads
  # POST /uploads.json
  def create
    @upload = Upload.new(params[:upload])

    respond_to do |format|
      if @upload.save
        format.html { redirect_to @upload, notice: 'Upload was successfully created.' }
        format.json { render json: @upload, status: :created, location: @upload }
      else
        format.html { render action: "new" }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /uploads/1
  # PUT /uploads/1.json
  def update
    @upload = Upload.find(params[:id])

    respond_to do |format|
      if @upload.update_attributes(params[:upload])
        format.html { redirect_to @upload, notice: 'Upload was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy

    respond_to do |format|
      format.html { redirect_to uploads_url }
      format.json { head :no_content }
    end
  end
end
=======
class UploadsController < ApplicationController
  before_filter :authenticate
  layout 'administration'
  require RAILS_ROOT + '/vendor/plugins/responds_to_parent/init.rb'
  require 'net/http'
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @uploads = Upload.paginate :page => params[:page]
  end

  def show
    @upload = Upload.find(params[:id])
  end

  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new(params[:upload])
    if @upload.save
      flash[:notice] = 'Upload was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @upload = Upload.find(params[:id])
  end

  def update
    @upload = Upload.find(params[:id])
    if @upload.update_attributes(params[:upload])
      flash[:notice] = 'Upload was successfully updated.'
      redirect_to :action => 'show', :id => @upload
    else
      render :action => 'edit'
    end
  end

  def destroy
    Upload.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def uploadFile
    @upload = Upload.new(:created_by => session[:user_id], :uploadable_type => params[:uploadable_type])
    @upload.upload_data= params[:upload]
    @upload.uploadable_type= params[:uploadable_type]
    @upload.save
    responds_to_parent do
      render :update do |page|
        page.insert_html :bottom, 'upload_list', :partial => 'upload'
      end
    end
  end

  def downloadFile
    @download = Upload.find(params[:id])
    send_file(RAILS_ROOT + "/public/data/" + @download.name, :filename => @download.name)
  end
end
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
