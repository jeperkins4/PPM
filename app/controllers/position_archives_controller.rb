class PositionArchivesController < ApplicationController

layout 'administration'

  def index
    @position_archives = PositionArchive.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @position_archives.to_xml }
    end
  end

  # GET /position_archives/1
  # GET /position_archives/1.xml
  def show
    @position_archive = PositionArchive.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @position_archive.to_xml }
    end
  end

  # GET /position_archives/new
  def new
    @position_archive = PositionArchive.new
  end

  # GET /position_archives/1;edit
  def edit
    @position_archive = PositionArchive.find(params[:id])
  end

  # POST /position_archives
  # POST /position_archives.xml
  def create
    @position_archive = PositionArchive.new(params[:position_archive])

    respond_to do |format|
      if @position_archive.save
        flash[:notice] = 'PositionArchive was successfully created.'
        format.html { redirect_to position_archive_url(@position_archive) }
        format.xml  { head :created, :location => position_archive_url(@position_archive) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @position_archive.errors.to_xml }
      end
    end
  end

  # PUT /position_archives/1
  # PUT /position_archives/1.xml
  def update
    @position_archive = PositionArchive.find(params[:id])

    respond_to do |format|
      if @position_archive.update_attributes(params[:position_archive])
        flash[:notice] = 'PositionArchive was successfully updated.'
        format.html { redirect_to position_archive_url(@position_archive) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @position_archive.errors.to_xml }
      end
    end
  end

  # DELETE /position_archives/1
  # DELETE /position_archives/1.xml
  def destroy
    @position_archive = PositionArchive.find(params[:id])
    @position_archive.destroy

    respond_to do |format|
      format.html { redirect_to position_archives_url }
      format.xml  { head :ok }
    end
  end
end
