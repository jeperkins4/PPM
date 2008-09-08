class CustodyTypesController < ApplicationController
  before_filter :admin_authenticate
  layout 'administration'
  # GET /custody_types.xml
  def index
    @custody_types = CustodyType.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @custody_types.to_xml }
    end
  end

  # GET /custody_types/1
  # GET /custody_types/1.xml
  def show
    @custody_type = CustodyType.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @custody_type.to_xml }
    end
  end

  # GET /custody_types/new
  def new
    @custody_type = CustodyType.new
  end

  # GET /custody_types/1;edit
  def edit
    @custody_type = CustodyType.find(params[:id])
  end

  # POST /custody_types
  # POST /custody_types.xml
  def create
    @custody_type = CustodyType.new(params[:custody_type])

    respond_to do |format|
      if @custody_type.save
        flash[:notice] = 'CustodyType was successfully created.'
        format.html { redirect_to custody_type_url(@custody_type) }
        format.xml  { head :created, :location => custody_type_url(@custody_type) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @custody_type.errors.to_xml }
      end
    end
  end

  # PUT /custody_types/1
  # PUT /custody_types/1.xml
  def update
    @custody_type = CustodyType.find(params[:id])

    respond_to do |format|
      if @custody_type.update_attributes(params[:custody_type])
        flash[:notice] = 'CustodyType was successfully updated.'
        format.html { redirect_to custody_type_url(@custody_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @custody_type.errors.to_xml }
      end
    end
  end

  # DELETE /custody_types/1
  # DELETE /custody_types/1.xml
  def destroy
    @custody_type = CustodyType.find(params[:id])
    @custody_type.destroy

    respond_to do |format|
      format.html { redirect_to custody_types_url }
      format.xml  { head :ok }
    end
  end
end
