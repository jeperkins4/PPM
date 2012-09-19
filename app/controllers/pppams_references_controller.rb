class PppamsReferencesController < ApplicationController
<<<<<<< HEAD
  # GET /pppams_references
  # GET /pppams_references.json
  def index
    @pppams_references = PppamsReference.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pppams_references }
=======
  before_filter :authenticate
  layout 'administration'  # GET /pppams_references
  # GET /pppams_references.xml
  def index
    @pppams_references = PppamsReference.paginate(:all, :per_page => 50, :page => params[:page], :order => 'name')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pppams_references }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end

  # GET /pppams_references/1
<<<<<<< HEAD
  # GET /pppams_references/1.json
=======
  # GET /pppams_references/1.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def show
    @pppams_reference = PppamsReference.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
<<<<<<< HEAD
      format.json { render json: @pppams_reference }
=======
      format.xml  { render :xml => @pppams_reference }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end

  # GET /pppams_references/new
<<<<<<< HEAD
  # GET /pppams_references/new.json
=======
  # GET /pppams_references/new.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def new
    @pppams_reference = PppamsReference.new

    respond_to do |format|
      format.html # new.html.erb
<<<<<<< HEAD
      format.json { render json: @pppams_reference }
=======
      format.xml  { render :xml => @pppams_reference }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end

  # GET /pppams_references/1/edit
  def edit
    @pppams_reference = PppamsReference.find(params[:id])
  end

  # POST /pppams_references
<<<<<<< HEAD
  # POST /pppams_references.json
=======
  # POST /pppams_references.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def create
    @pppams_reference = PppamsReference.new(params[:pppams_reference])

    respond_to do |format|
      if @pppams_reference.save
<<<<<<< HEAD
        format.html { redirect_to @pppams_reference, notice: 'Pppams reference was successfully created.' }
        format.json { render json: @pppams_reference, status: :created, location: @pppams_reference }
      else
        format.html { render action: "new" }
        format.json { render json: @pppams_reference.errors, status: :unprocessable_entity }
=======
        flash[:notice] = 'PppamsReference was successfully created.'
        format.html { redirect_to(@pppams_reference) }
        format.xml  { render :xml => @pppams_reference, :status => :created, :location => @pppams_reference }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pppams_reference.errors, :status => :unprocessable_entity }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
      end
    end
  end

  # PUT /pppams_references/1
<<<<<<< HEAD
  # PUT /pppams_references/1.json
=======
  # PUT /pppams_references/1.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def update
    @pppams_reference = PppamsReference.find(params[:id])

    respond_to do |format|
      if @pppams_reference.update_attributes(params[:pppams_reference])
<<<<<<< HEAD
        format.html { redirect_to @pppams_reference, notice: 'Pppams reference was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pppams_reference.errors, status: :unprocessable_entity }
=======
        flash[:notice] = 'PppamsReference was successfully updated.'
        format.html { redirect_to(@pppams_reference) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pppams_reference.errors, :status => :unprocessable_entity }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
      end
    end
  end

  # DELETE /pppams_references/1
<<<<<<< HEAD
  # DELETE /pppams_references/1.json
=======
  # DELETE /pppams_references/1.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def destroy
    @pppams_reference = PppamsReference.find(params[:id])
    @pppams_reference.destroy

    respond_to do |format|
<<<<<<< HEAD
      format.html { redirect_to pppams_references_url }
      format.json { head :no_content }
=======
      format.html { redirect_to(pppams_references_url) }
      format.xml  { head :ok }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end
end
