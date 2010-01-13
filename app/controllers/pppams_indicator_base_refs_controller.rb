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
      new_facility_indicators, indicators_to_deactivate = params[:pppams_indicator_base_ref][:pppams_indicators_attributes].
                                                            partition {|ind| ind.has_key? 'created_on(1i)' }

      create_indicators_for(new_facility_indicators) if new_facility_indicators

      deactivate_indicators_for(indicators_to_deactivate) if indicators_to_deactivate
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

      facility = Facility.find(facility_indicator_attributes[:facility_id], :select => 'facility')
      indicator_base = params[:id]
      indicator_id = facility_indicator_attributes[:id]
      valid_new_indicator_attributes = facility_indicator_attributes.reject! {|k,v| k.to_sym == :id }.
                                       merge({:pppams_indicator_base_ref_id => indicator_base})

      #separate out the date fields and the fields
      #that define a unique indicator
      created_on_date, find_attributes = valid_new_indicator_attributes.partition {|k,v| ['created_on(1i)',
                                                                      'created_on(2i)',
                                                                      'created_on(3i)'].include?(k) }
      #make the find and updated attributes into hashes
      #this would be much easier in Ruby 1.8.7
      find_attributes    = find_attributes.inject({})    {|memo, array| {array[0] => array[1]}.merge(memo) }
      created_on_date    = created_on_date.inject({}) {|memo, array| {array[0] => array[1]}.merge(memo) }

      #find or create the indicator,
      #then update its created_on date
      if PppamsIndicator.find_or_create_by_facility_id(find_attributes).try(:update_attributes, created_on_date) then
        flash[:notice] ||= []
        flash[:notice] << "Successfully added indicator for #{facility.facility}"
      else
        flash[:alert] ||= []
        flash[:alert] << "There was a problem creating the indicator for facility #{facility.facility}"
      end
    end
  end

  def deactivate_indicators_for(indicators_to_deactivate)
    indicators_to_deactivate.each do |indicator_to_deactivate|
      indicator_id = indicator_to_deactivate['id']
      inactive_on = indicator_to_deactivate.reject! {|k,v| k =~ /id|facility_id/}
      if PppamsIndicator.find(indicator_id).try(:update_attributes, inactive_on)
        flash[:notice] ||= []
        flash[:notice] << "Successfully deactivated an indicator"
      else
        flash[:alert] ||= []
        flash[:alert] << "There was a problem deactivating anindicator"
      end
    end
  end

end
