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

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pppams_indicator_base_ref }
    end
  end

  # GET /pppams_indicator_base_refs/new
  # GET /pppams_indicator_base_refs/new.xml
  def new
    @pppams_indicator_base_ref = PppamsIndicatorBaseRef.new
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

    if params[:pppams_indicator_base_ref].try('has_key?', :pppams_indicators_attributes)
      new_facility_indicators, indicators_to_deactivate = params[:pppams_indicator_base_ref][:pppams_indicators_attributes].partition {|ind| ind['created_on(1i)'] }

      create_indicators_for new_facility_indicators

      deactivate_indicators_for indicators_to_deactivate
    end

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

  private

  def create_indicators_for(new_facility_indicators)
    new_facility_indicators.each do |facility_indicator_attributes|

      facility = Facility.find(facility_indicator_attributes[:facility_id])
      indicator_base = params[:id]

      valid_new_indicator_attributes = facility_indicator_attributes.reject! {|k,v| k.to_sym == :id }.
                                       merge({:pppams_indicator_base_ref_id => indicator_base})


      if PppamsIndicator.create(valid_new_indicator_attributes).errors.nil?
        flash[:notice] ||= []
        flash[:notice] << "Successfully added indicator for #{facility.facility}"
      else
        flash[:alert] ||= []
        flash[:alert] << "There was a problem creating the indicator for facility #{facility.facility}"
      end
    end
  end

  def deactivate_indicators_for(indicators_to_deactivate)

  end

end
