class PppamsCategoryBaseRefsController < ApplicationController
  before_filter :authenticate
  layout 'administration'
  # GET /pppams_category_base_refs
  # GET /pppams_category_base_refs.xml
  def index
    @pppams_category_base_refs = PppamsCategoryBaseRef.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pppams_category_base_refs }
    end
  end

  # GET /pppams_category_base_refs/1
  # GET /pppams_category_base_refs/1.xml
  def show
    @pppams_category_base_ref = PppamsCategoryBaseRef.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pppams_category_base_ref }
    end
  end

  # GET /pppams_category_base_refs/new
  # GET /pppams_category_base_refs/new.xml
  def new
    @pppams_category_base_ref = PppamsCategoryBaseRef.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pppams_category_base_ref }
    end
  end

  # GET /pppams_category_base_refs/1/edit
  def edit
    @pppams_category_base_ref = PppamsCategoryBaseRef.find(params[:id])
  end

  # POST /pppams_category_base_refs
  # POST /pppams_category_base_refs.xml
  def create
    @pppams_category_base_ref = PppamsCategoryBaseRef.new(params[:pppams_category_base_ref])

    respond_to do |format|
      if @pppams_category_base_ref.save
        flash[:notice] = 'PppamsCategoryBaseRef was successfully created.'
        format.html { redirect_to(@pppams_category_base_ref) }
        format.xml  { render :xml => @pppams_category_base_ref, :status => :created, :location => @pppams_category_base_ref }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pppams_category_base_ref.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pppams_category_base_refs/1
  # PUT /pppams_category_base_refs/1.xml
  def update
    @pppams_category_base_ref = PppamsCategoryBaseRef.find(params[:id])

    respond_to do |format|
      if @pppams_category_base_ref.update_attributes(params[:pppams_category_base_ref])
        flash[:notice] = 'PppamsCategoryBaseRef was successfully updated.'
        format.html { redirect_to(@pppams_category_base_ref) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pppams_category_base_ref.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pppams_category_base_refs/1
  # DELETE /pppams_category_base_refs/1.xml
  def destroy
    @pppams_category_base_ref = PppamsCategoryBaseRef.find(params[:id])
    @pppams_category_base_ref.destroy

    respond_to do |format|
      format.html { redirect_to(pppams_category_base_refs_url) }
      format.xml  { head :ok }
    end
  end
end
