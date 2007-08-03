class InmatesController < ApplicationController
  before_filter :authenticate 
  layout 'administration'
  def index
    @inmates = Inmate.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @inmates.to_xml }
    end
  end

  # GET /inmates/1
  # GET /inmates/1.xml
  def show
    @inmate = Inmate.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @inmate.to_xml }
    end
  end

  # GET /inmates/new
  def new
    @inmate = Inmate.new
  end

  # GET /inmates/1;edit
  def edit
    @inmate = Inmate.find(params[:id])
  end

  # POST /inmates
  # POST /inmates.xml
  def create
    @inmate = Inmate.new(params[:inmate])

    respond_to do |format|
      if @inmate.save
        flash[:notice] = 'Inmate was successfully created.'
        format.html { redirect_to inmate_url(@inmate) }
        format.xml  { head :created, :location => inmate_url(@inmate) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @inmate.errors.to_xml }
      end
    end
  end

  # PUT /inmates/1
  # PUT /inmates/1.xml
  def update
    @inmate = Inmate.find(params[:id])

    respond_to do |format|
      if @inmate.update_attributes(params[:inmate])
        flash[:notice] = 'Inmate was successfully updated.'
        format.html { redirect_to inmate_url(@inmate) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @inmate.errors.to_xml }
      end
    end
  end

  # DELETE /inmates/1
  # DELETE /inmates/1.xml
  def destroy
    @inmate = Inmate.find(params[:id])
    @inmate.destroy

    respond_to do |format|
      format.html { redirect_to inmates_url }
      format.xml  { head :ok }
    end
  end
end
