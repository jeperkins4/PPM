class PppamsCategoryBaseRefsController < ApplicationController
<<<<<<< HEAD
  # GET /pppams_category_base_refs
  # GET /pppams_category_base_refs.json
  def index
    @pppams_category_base_refs = PppamsCategoryBaseRef.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pppams_category_base_refs }
=======
  before_filter :authenticate
  layout 'administration'
  # GET /pppams_category_base_refs
  # GET /pppams_category_base_refs.xml
  def index
    @pppams_category_base_refs = PppamsCategoryBaseRef.paginate(:all, :page =>  params[:page], :per_page => 30)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pppams_category_base_refs }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end

  # GET /pppams_category_base_refs/1
<<<<<<< HEAD
  # GET /pppams_category_base_refs/1.json
  def show
    @pppams_category_base_ref = PppamsCategoryBaseRef.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pppams_category_base_ref }
=======
  # GET /pppams_category_base_refs/1.xml
  def show
    @pppams_category_base_ref = PppamsCategoryBaseRef.find(params[:id], :include => [:pppams_indicator_base_refs])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pppams_category_base_ref }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end

  # GET /pppams_category_base_refs/new
<<<<<<< HEAD
  # GET /pppams_category_base_refs/new.json
  def new
    @pppams_category_base_ref = PppamsCategoryBaseRef.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pppams_category_base_ref }
=======
  # GET /pppams_category_base_refs/new.xml
  def new
    @pppams_category_base_ref = PppamsCategoryBaseRef.new
    @pppams_category_groups = PppamsCategoryGroup.all.map { |pcg| [pcg.name, pcg.id] }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pppams_category_base_ref }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end

  # GET /pppams_category_base_refs/1/edit
  def edit
<<<<<<< HEAD
    @pppams_category_base_ref = PppamsCategoryBaseRef.find(params[:id])
  end

  # POST /pppams_category_base_refs
  # POST /pppams_category_base_refs.json
=======
    @pppams_category_base_ref = PppamsCategoryBaseRef.find(params[:id], :include => [:pppams_indicator_base_refs])
    @facilities_with_base = Facility.with_category_base(params[:id])
    @pppams_category_groups = PppamsCategoryGroup.all.map { |pcg| [pcg.name, pcg.id] }
  end

  # POST /pppams_category_base_refs
  # POST /pppams_category_base_refs.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def create
    @pppams_category_base_ref = PppamsCategoryBaseRef.new(params[:pppams_category_base_ref])

    respond_to do |format|
      if @pppams_category_base_ref.save
<<<<<<< HEAD
        format.html { redirect_to @pppams_category_base_ref, notice: 'Pppams category base ref was successfully created.' }
        format.json { render json: @pppams_category_base_ref, status: :created, location: @pppams_category_base_ref }
      else
        format.html { render action: "new" }
        format.json { render json: @pppams_category_base_ref.errors, status: :unprocessable_entity }
=======
        flash[:notice] = 'PppamsCategoryBaseRef was successfully created.'
        format.html { redirect_to(@pppams_category_base_ref) }
        format.xml  { render :xml => @pppams_category_base_ref, :status => :created, :location => @pppams_category_base_ref }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pppams_category_base_ref.errors, :status => :unprocessable_entity }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
      end
    end
  end

  # PUT /pppams_category_base_refs/1
<<<<<<< HEAD
  # PUT /pppams_category_base_refs/1.json
=======
  # PUT /pppams_category_base_refs/1.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def update
    @pppams_category_base_ref = PppamsCategoryBaseRef.find(params[:id])

    respond_to do |format|
      if @pppams_category_base_ref.update_attributes(params[:pppams_category_base_ref])
<<<<<<< HEAD
        format.html { redirect_to @pppams_category_base_ref, notice: 'Pppams category base ref was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pppams_category_base_ref.errors, status: :unprocessable_entity }
=======
        flash[:notice] = 'PppamsCategoryBaseRef was successfully updated.'
        format.html { redirect_to(@pppams_category_base_ref) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pppams_category_base_ref.errors, :status => :unprocessable_entity }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
      end
    end
  end

  # DELETE /pppams_category_base_refs/1
<<<<<<< HEAD
  # DELETE /pppams_category_base_refs/1.json
=======
  # DELETE /pppams_category_base_refs/1.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def destroy
    @pppams_category_base_ref = PppamsCategoryBaseRef.find(params[:id])
    @pppams_category_base_ref.destroy

    respond_to do |format|
<<<<<<< HEAD
      format.html { redirect_to pppams_category_base_refs_url }
      format.json { head :no_content }
=======
      format.html { redirect_to(pppams_category_base_refs_url) }
      format.xml  { head :ok }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end
end
