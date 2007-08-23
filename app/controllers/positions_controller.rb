class PositionsController < ApplicationController

layout 'administration'

  def index
    @positions = Position.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @positions.to_xml }
    end
  end

  # GET /positions/1
  # GET /positions/1.xml
  def show
    @position = Position.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @position.to_xml }
    end
  end

  # GET /positions/new
  def new
    @position = Position.new
  end

  # GET /positions/1;edit
  def edit
    @position = Position.find(params[:id])
  end

  # POST /positions
  # POST /positions.xml
  def create
    @position = Position.new(params[:position])

    respond_to do |format|
      if @position.save
        flash[:notice] = 'Position was successfully created.'
        format.html { redirect_to position_url(@position) }
        format.xml  { head :created, :location => position_url(@position) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @position.errors.to_xml }
      end
    end
  end

  # PUT /positions/1
  # PUT /positions/1.xml
  def update
    @position = Position.find(params[:id])

    respond_to do |format|
      if @position.update_attributes(params[:position])
        flash[:notice] = 'Position was successfully updated.'
        format.html { redirect_to position_url(@position) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @position.errors.to_xml }
      end
    end
  end

  # DELETE /positions/1
  # DELETE /positions/1.xml
  def destroy
    @position = Position.find(params[:id])
    @position.destroy

    respond_to do |format|
      format.html { redirect_to positions_url }
      format.xml  { head :ok }
    end
  end
end
