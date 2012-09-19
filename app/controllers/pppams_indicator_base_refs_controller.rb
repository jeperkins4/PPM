class PppamsIndicatorBaseRefsController < ApplicationController
<<<<<<< HEAD
  # GET /pppams_indicator_base_refs
  # GET /pppams_indicator_base_refs.json
  def index
    @pppams_indicator_base_refs = PppamsIndicatorBaseRef.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pppams_indicator_base_refs }
=======
  before_filter :authenticate
  layout 'administration'
  # GET /pppams_indicator_base_refs
  # GET /pppams_indicator_base_refs.xml
  def index
    @pppams_indicator_base_refs = PppamsIndicatorBaseRef.paginate(:all, :per_page => 20, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pppams_indicator_base_refs }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end

  # GET /pppams_indicator_base_refs/1
<<<<<<< HEAD
  # GET /pppams_indicator_base_refs/1.json
  def show
    @pppams_indicator_base_ref = PppamsIndicatorBaseRef.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pppams_indicator_base_ref }
=======
  # GET /pppams_indicator_base_refs/1.xml
  def show
    @pppams_indicator_base_ref = PppamsIndicatorBaseRef.find(params[:id], :include => :pppams_indicators)
    @facilities = @pppams_indicator_base_ref.current_facilities_hash

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pppams_indicator_base_ref }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end

  # GET /pppams_indicator_base_refs/new
<<<<<<< HEAD
  # GET /pppams_indicator_base_refs/new.json
  def new
    @pppams_indicator_base_ref = PppamsIndicatorBaseRef.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pppams_indicator_base_ref }
=======
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
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end

  # GET /pppams_indicator_base_refs/1/edit
  def edit
    @pppams_indicator_base_ref = PppamsIndicatorBaseRef.find(params[:id])
<<<<<<< HEAD
  end

  # POST /pppams_indicator_base_refs
  # POST /pppams_indicator_base_refs.json
=======
    @facilities = PppamsIndicatorBaseRef.current_facilities_hash(params[:id])
  end

  # POST /pppams_indicator_base_refs
  # POST /pppams_indicator_base_refs.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def create
    @pppams_indicator_base_ref = PppamsIndicatorBaseRef.new(params[:pppams_indicator_base_ref])

    respond_to do |format|
      if @pppams_indicator_base_ref.save
<<<<<<< HEAD
        format.html { redirect_to @pppams_indicator_base_ref, notice: 'Pppams indicator base ref was successfully created.' }
        format.json { render json: @pppams_indicator_base_ref, status: :created, location: @pppams_indicator_base_ref }
      else
        format.html { render action: "new" }
        format.json { render json: @pppams_indicator_base_ref.errors, status: :unprocessable_entity }
=======
        flash[:notice] = 'PppamsIndicatorBaseRef was successfully created.'
        format.html { redirect_to(@pppams_indicator_base_ref) }
        format.xml  { render :xml => @pppams_indicator_base_ref, :status => :created, :location => @pppams_indicator_base_ref }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pppams_indicator_base_ref.errors, :status => :unprocessable_entity }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
      end
    end
  end

  # PUT /pppams_indicator_base_refs/1
<<<<<<< HEAD
  # PUT /pppams_indicator_base_refs/1.json
  def update
    @pppams_indicator_base_ref = PppamsIndicatorBaseRef.find(params[:id])

    respond_to do |format|
      if @pppams_indicator_base_ref.update_attributes(params[:pppams_indicator_base_ref])
        format.html { redirect_to @pppams_indicator_base_ref, notice: 'Pppams indicator base ref was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pppams_indicator_base_ref.errors, status: :unprocessable_entity }
=======
  # PUT /pppams_indicator_base_refs/1.xml
  def update
    @pppams_indicator_base_ref = PppamsIndicatorBaseRef.find(params[:id])

    new_attributes = params[:pppams_indicator_base_ref]

    #delete blank settings in pppams_indicators settings
    new_indicators = new_attributes[:pppams_indicators_attributes].inject({}) do |result, indicator_settings|
      indicator_settings[1] = indicator_settings[1].delete_if {|key, value| value.blank?}
      result[indicator_settings[0]]=indicator_settings[1]
      result
    end
    new_attributes[:pppams_indicators_attributes]=new_indicators
    new_attributes[:pppams_reference_ids]= [] unless new_attributes[:pppams_reference_ids]
    respond_to do |format|
      if @pppams_indicator_base_ref.update_attributes(new_attributes)
        flash[:notice] = 'The Global Indicator was successfully updated.'
        format.html { redirect_to(edit_pppams_indicator_base_ref_path(@pppams_indicator_base_ref)) }
        format.xml  { head :ok }
      else
        format.html { redirect_to :action => "edit" }
        format.xml  { render :xml => @pppams_indicator_base_ref.errors, :status => :unprocessable_entity }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
      end
    end
  end

<<<<<<< HEAD
  # DELETE /pppams_indicator_base_refs/1
  # DELETE /pppams_indicator_base_refs/1.json
  def destroy
    @pppams_indicator_base_ref = PppamsIndicatorBaseRef.find(params[:id])
    @pppams_indicator_base_ref.destroy

    respond_to do |format|
      format.html { redirect_to pppams_indicator_base_refs_url }
      format.json { head :no_content }
    end
  end
=======
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
end
