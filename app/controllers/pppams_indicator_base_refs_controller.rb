class PppamsIndicatorBaseRefsController < ApplicationController
  before_filter :authenticate
  layout 'administration'
  # GET /pppams_indicator_base_refs
  # GET /pppams_indicator_base_refs.xml
  def index
    @pppams_indicator_base_refs = PppamsIndicatorBaseRef.paginate(:all, :per_page => 20, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pppams_indicator_base_refs }
    end
  end

  # GET /pppams_indicator_base_refs/1
  # GET /pppams_indicator_base_refs/1.xml
  def show
    @pppams_indicator_base_ref = PppamsIndicatorBaseRef.find(params[:id])
    @facilities = @pppams_indicator_base_ref.current_facilities_hash

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pppams_indicator_base_ref }
    end
  end

  # GET /pppams_indicator_base_refs/new
  # GET /pppams_indicator_base_refs/new.xml
  def new
    if params[:pppams_category_base_ref_id]
      @pppams_indicator_base_ref = PppamsIndicatorBaseRef.new(:pppams_category_base_ref_id => params[:pppams_category_base_ref_id])
    else
      @pppams_indicator_base_ref = PppamsIndicatorBaseRef.new
    end
    @pppams_category_base_refs = PppamsCategoryBaseRef.all.map { |pcb| [pcb.name, pcb.id]}    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pppams_indicator_base_ref }
    end
  end

  # GET /pppams_indicator_base_refs/1/edit
  def edit
    @pppams_indicator_base_ref = PppamsIndicatorBaseRef.find(params[:id])
    @facilities = PppamsIndicatorBaseRef.current_facilities_hash(params[:id])
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
        flash[:notice] = 'The Global Indicator was successfully updated.'
        format.html { redirect_to(edit_pppams_indicator_base_ref_path(@pppams_indicator_base_ref)) }
        format.xml  { head :ok }
      else
        format.html { redirect_to :action => "edit" }
        format.xml  { render :xml => @pppams_indicator_base_ref.errors, :status => :unprocessable_entity }
      end
    end
  end

end
