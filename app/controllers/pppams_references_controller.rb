class PppamsReferencesController < ApplicationController
  before_filter :authenticate
  layout 'administration'  # GET /pppams_references
  # GET /pppams_references.xml
  def index
    @pppams_references = PppamsReference.paginate(:all, :per_page => 50, :page => params[:page], :order => 'name')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pppams_references }
    end
  end

  # GET /pppams_references/1
  # GET /pppams_references/1.xml
  def show
    @pppams_reference = PppamsReference.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pppams_reference }
    end
  end

  # GET /pppams_references/new
  # GET /pppams_references/new.xml
  def new
    @pppams_reference = PppamsReference.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pppams_reference }
    end
  end

  # GET /pppams_references/1/edit
  def edit
    @pppams_reference = PppamsReference.find(params[:id])
  end

  # POST /pppams_references
  # POST /pppams_references.xml
  def create
    @pppams_reference = PppamsReference.new(params[:pppams_reference])

    respond_to do |format|
      if @pppams_reference.save
        flash[:notice] = 'PppamsReference was successfully created.'
        format.html { redirect_to(@pppams_reference) }
        format.xml  { render :xml => @pppams_reference, :status => :created, :location => @pppams_reference }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pppams_reference.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pppams_references/1
  # PUT /pppams_references/1.xml
  def update
    @pppams_reference = PppamsReference.find(params[:id])

    respond_to do |format|
      if @pppams_reference.update_attributes(params[:pppams_reference])
        flash[:notice] = 'PppamsReference was successfully updated.'
        format.html { redirect_to(@pppams_reference) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pppams_reference.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pppams_references/1
  # DELETE /pppams_references/1.xml
  def destroy
    @pppams_reference = PppamsReference.find(params[:id])
    @pppams_reference.destroy

    respond_to do |format|
      format.html { redirect_to(pppams_references_url) }
      format.xml  { head :ok }
    end
  end
end
