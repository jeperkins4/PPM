class PositionTypesController < ApplicationController
 before_filter :authenticate
layout 'administration'

  def index
    @position_types = PositionType.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @position_types.to_xml }
    end
  end

  # GET /position_types/1
  # GET /position_types/1.xml
  def show
    @position_type = PositionType.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @position_type.to_xml }
    end
  end

  # GET /position_types/new
  def new
    @position_type = PositionType.new
  end

  # GET /position_types/1;edit
  def edit
    @position_type = PositionType.find(params[:id])
  end

  # POST /position_types
  # POST /position_types.xml
  def create
    @position_type = PositionType.new(params[:position_type])

    respond_to do |format|
      if @position_type.save
        flash[:notice] = 'PositionType was successfully created.'
        format.html { redirect_to position_type_url(@position_type) }
        format.xml  { head :created, :location => position_type_url(@position_type) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @position_type.errors.to_xml }
      end
    end
  end

  # PUT /position_types/1
  # PUT /position_types/1.xml
  def update
    @position_type = PositionType.find(params[:id])

    respond_to do |format|
      if @position_type.update_attributes(params[:position_type])
        flash[:notice] = 'PositionType was successfully updated.'
        format.html { redirect_to position_type_url(@position_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @position_type.errors.to_xml }
      end
    end
  end

  # DELETE /position_types/1
  # DELETE /position_types/1.xml
  def destroy
    @position_type = PositionType.find(params[:id])
    @position_type.destroy

    respond_to do |format|
      format.html { redirect_to position_types_url }
      format.xml  { head :ok }
    end
  end
end
