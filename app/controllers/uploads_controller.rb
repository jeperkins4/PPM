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
    @upload_pages, @uploads = paginate :uploads, :per_page => 10
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
    @upload = Upload.new(:created_by => session[:user_id])
    @upload.upload_data= params[:upload]
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
