class PppamsIndicatorBaseRefsController < ApplicationController
  # GET /pppams_indicator_base_refs
  # GET /pppams_indicator_base_refs.xml
  def index
    @pppams_indicator_base_refs = PppamsIndicatorBaseRef.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pppams_indicator_base_refs }
    end
  end

  # GET /pppams_indicator_base_refs/1
  # GET /pppams_indicator_base_refs/1.xml
  def show
    @pppams_indicator_base_ref = PppamsIndicatorBaseRef.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pppams_indicator_base_ref }
    end
  end

  # GET /pppams_indicator_base_refs/new
  # GET /pppams_indicator_base_refs/new.xml
  def new
    @pppams_indicator_base_ref = PppamsIndicatorBaseRef.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pppams_indicator_base_ref }
    end
  end

  # GET /pppams_indicator_base_refs/1/edit
  def edit
    @pppams_indicator_base_ref = PppamsIndicatorBaseRef.find(params[:id])
  end

  # POST /pppams_indicator_base_refs
  # POST /pppams_indicator_base_refs.xml
  def create
    @pppams_indicator_base_ref = PppamsIndicatorBaseRef.new(params[:pppams_indicator_base_ref])

    respond_to do |format|
      if @pppams_indicator_base_ref.save
        flash[:notice] = 'PppamsIndicatorBaseRef was successfully created.'
        format.html { redirect_to(@pppams_indicator_base_ref) }
        format.xml  { render :xml => @pppams_indicator_base_ref, :status => :created, :location => @pppams_indicator_base_ref }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pppams_indicator_base_ref.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pppams_indicator_base_refs/1
  # PUT /pppams_indicator_base_refs/1.xml
  def update
    @pppams_indicator_base_ref = PppamsIndicatorBaseRef.find(params[:id])

    respond_to do |format|
      if @pppams_indicator_base_ref.update_attributes(params[:pppams_indicator_base_ref])
        flash[:notice] = 'PppamsIndicatorBaseRef was successfully updated.'
        format.html { redirect_to(@pppams_indicator_base_ref) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pppams_indicator_base_ref.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pppams_indicator_base_refs/1
  # DELETE /pppams_indicator_base_refs/1.xml
  def destroy
    @pppams_indicator_base_ref = PppamsIndicatorBaseRef.find(params[:id])
    @pppams_indicator_base_ref.destroy

    respond_to do |format|
      format.html { redirect_to(pppams_indicator_base_refs_url) }
      format.xml  { head :ok }
    end
  end
end
