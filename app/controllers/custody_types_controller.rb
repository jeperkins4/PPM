class CustodyTypesController < ApplicationController
<<<<<<< HEAD
  # GET /custody_types
  # GET /custody_types.json
  def index
    @custody_types = CustodyType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @custody_types }
=======
  before_filter :admin_authenticate
  layout 'administration'
  # GET /custody_types.xml
  def index
    @custody_types = CustodyType.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @custody_types.to_xml }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end

  # GET /custody_types/1
<<<<<<< HEAD
  # GET /custody_types/1.json
=======
  # GET /custody_types/1.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def show
    @custody_type = CustodyType.find(params[:id])

    respond_to do |format|
<<<<<<< HEAD
      format.html # show.html.erb
      format.json { render json: @custody_type }
=======
      format.html # show.rhtml
      format.xml  { render :xml => @custody_type.to_xml }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end

  # GET /custody_types/new
<<<<<<< HEAD
  # GET /custody_types/new.json
  def new
    @custody_type = CustodyType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @custody_type }
    end
  end

  # GET /custody_types/1/edit
=======
  def new
    @custody_type = CustodyType.new
  end

  # GET /custody_types/1;edit
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def edit
    @custody_type = CustodyType.find(params[:id])
  end

  # POST /custody_types
<<<<<<< HEAD
  # POST /custody_types.json
=======
  # POST /custody_types.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def create
    @custody_type = CustodyType.new(params[:custody_type])

    respond_to do |format|
      if @custody_type.save
<<<<<<< HEAD
        format.html { redirect_to @custody_type, notice: 'Custody type was successfully created.' }
        format.json { render json: @custody_type, status: :created, location: @custody_type }
      else
        format.html { render action: "new" }
        format.json { render json: @custody_type.errors, status: :unprocessable_entity }
=======
        flash[:notice] = 'CustodyType was successfully created.'
        format.html { redirect_to custody_type_url(@custody_type) }
        format.xml  { head :created, :location => custody_type_url(@custody_type) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @custody_type.errors.to_xml }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
      end
    end
  end

  # PUT /custody_types/1
<<<<<<< HEAD
  # PUT /custody_types/1.json
=======
  # PUT /custody_types/1.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def update
    @custody_type = CustodyType.find(params[:id])

    respond_to do |format|
      if @custody_type.update_attributes(params[:custody_type])
<<<<<<< HEAD
        format.html { redirect_to @custody_type, notice: 'Custody type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @custody_type.errors, status: :unprocessable_entity }
=======
        flash[:notice] = 'CustodyType was successfully updated.'
        format.html { redirect_to custody_type_url(@custody_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @custody_type.errors.to_xml }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
      end
    end
  end

  # DELETE /custody_types/1
<<<<<<< HEAD
  # DELETE /custody_types/1.json
=======
  # DELETE /custody_types/1.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def destroy
    @custody_type = CustodyType.find(params[:id])
    @custody_type.destroy

    respond_to do |format|
      format.html { redirect_to custody_types_url }
<<<<<<< HEAD
      format.json { head :no_content }
=======
      format.xml  { head :ok }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end
end
