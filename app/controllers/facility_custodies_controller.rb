class FacilityCustodiesController < ApplicationController
 
 layout 'administration'
 
  def index
    @facility_custodies = FacilityCustody.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @facility_custodies.to_xml }
    end
  end

  # GET /facility_custodies/1
  # GET /facility_custodies/1.xml
  def show
    @facility_custody = FacilityCustody.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @facility_custody.to_xml }
    end
  end

  # GET /facility_custodies/new
  def new
    @facility = Facility.find(params[:facility_id])
    @custody_type = CustodyType.find(:all).delete_if{|custody_type_id| @facility.custody_types.include?(custody_type_id)}
    @facility_custody = FacilityCustody.new
  end

  # GET /facility_custodies/1;edit
  def edit
    @facility_custody = FacilityCustody.find(params[:id])
  end

  # POST /facility_custodies
  # POST /facility_custodies.xml
  def create
    @facility = Facility.find(params[:facility_id])
    @facility_custody = FacilityCustody.new(params[:facility_custody])

    respond_to do |format|
      if @facility_custody.save
        flash[:notice] = 'Custody Type was sucessfully added.'
        format.html { redirect_to facility_url(@facility) }
        format.xml  { head :created, :location => facility_path(@facility) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @facility_custody.errors.to_xml }
      end
    end
  end

  # PUT /facility_custodies/1
  # PUT /facility_custodies/1.xml
  def update
    @facility_custody = FacilityCustody.find(params[:id])

    respond_to do |format|
      if @facility_custody.update_attributes(params[:facility_custody])
        flash[:notice] = 'FacilityCustody was successfully updated.'
        format.html { redirect_to facility_custody_url(@facility_custody) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @facility_custody.errors.to_xml }
      end
    end
  end

  # DELETE /facility_custodies/1
  # DELETE /facility_custodies/1.xml
  def destroy
    @facility = Facility.find(params[:facility_id])
    @facility_custody = FacilityCustody.find(params[:id])
    @facility_custody.destroy

    respond_to do |format|
      format.html { redirect_to facility_url(@facility) }
      format.xml  { head :ok }
    end
  end
end
