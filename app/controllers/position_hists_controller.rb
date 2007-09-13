class PositionHistsController < ApplicationController

 before_filter :admin_authenticate, :except => :reset_password
  layout 'administration'  
  
  # GET /position_hists
  # GET /position_hists.xml
  def index
    @position_hists = PositionHist.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @position_hists.to_xml }
    end
  end

  # GET /position_hists/1
  # GET /position_hists/1.xml
  def show
    @position_hist = PositionHist.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @position_hist.to_xml }
    end
  end

  # GET /position_hists/new
  def new
    @position_hist = PositionHist.new
  end

  # GET /position_hists/1;edit
  def edit
    @position_hist = PositionHist.find(params[:id])
  end

  # POST /position_hists
  # POST /position_hists.xml
  def create
    @position_hist = PositionHist.new(params[:position_hist])

    respond_to do |format|
      if @position_hist.save
        flash[:notice] = 'PositionHist was successfully created.'
        format.html { redirect_to position_hist_url(@position_hist) }
        format.xml  { head :created, :location => position_hist_url(@position_hist) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @position_hist.errors.to_xml }
      end
    end
  end

  # PUT /position_hists/1
  # PUT /position_hists/1.xml
  def update
    @position_hist = PositionHist.find(params[:id])

    respond_to do |format|
      if @position_hist.update_attributes(params[:position_hist])
        flash[:notice] = 'PositionHist was successfully updated.'
        format.html { redirect_to position_hist_url(@position_hist) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @position_hist.errors.to_xml }
      end
    end
  end

  # DELETE /position_hists/1
  # DELETE /position_hists/1.xml
  def destroy
    @position_hist = PositionHist.find(params[:id])
    @position_hist.destroy

    respond_to do |format|
      format.html { redirect_to position_hists_url }
      format.xml  { head :ok }
    end
  end
end
