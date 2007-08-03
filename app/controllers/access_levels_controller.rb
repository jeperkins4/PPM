class AccessLevelsController < ApplicationController
before_filter :admin_authenticate
layout 'administration'

  def index
    @access_levels = AccessLevel.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @access_levels.to_xml }
    end
  end

  # GET /access_levels/1
  # GET /access_levels/1.xml
  def show
    @access_level = AccessLevel.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @access_level.to_xml }
    end
  end

  # GET /access_levels/new
  def new
    @access_level = AccessLevel.new
  end

  # GET /access_levels/1;edit
  def edit
    @access_level = AccessLevel.find(params[:id])
  end

  # POST /access_levels
  # POST /access_levels.xml
  def create
    @access_level = AccessLevel.new(params[:access_level])

    respond_to do |format|
      if @access_level.save
        flash[:notice] = 'AccessLevel was successfully created.'
        format.html { redirect_to access_level_url(@access_level) }
        format.xml  { head :created, :location => access_level_url(@access_level) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @access_level.errors.to_xml }
      end
    end
  end

  # PUT /access_levels/1
  # PUT /access_levels/1.xml
  def update
    @access_level = AccessLevel.find(params[:id])

    respond_to do |format|
      if @access_level.update_attributes(params[:access_level])
        flash[:notice] = 'AccessLevel was successfully updated.'
        format.html { redirect_to access_level_url(@access_level) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @access_level.errors.to_xml }
      end
    end
  end

  # DELETE /access_levels/1
  # DELETE /access_levels/1.xml
  def destroy
    @access_level = AccessLevel.find(params[:id])
    @access_level.destroy

    respond_to do |format|
      format.html { redirect_to access_levels_url }
      format.xml  { head :ok }
    end
  end
end
