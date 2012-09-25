class PositionTypesController < ApplicationController
  # GET /position_types
  # GET /position_types.json
  def index
    @position_types = PositionType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @position_types }
    end
  end

  # GET /position_types/1
  # GET /position_types/1.json
  def show
    @position_type = PositionType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @position_type }
    end
  end

  # GET /position_types/new
  # GET /position_types/new.json
  def new
    @position_type = PositionType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @position_type }
    end
  end

  # GET /position_types/1/edit
  def edit
    @position_type = PositionType.find(params[:id])
  end

  # POST /position_types
  # POST /position_types.json
  def create
    @position_type = PositionType.new(params[:position_type])

    respond_to do |format|
      if @position_type.save
        format.html { redirect_to @position_type, notice: 'Position type was successfully created.' }
        format.json { render json: @position_type, status: :created, location: @position_type }
      else
        format.html { render action: "new" }
        format.json { render json: @position_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /position_types/1
  # PUT /position_types/1.json
  def update
    @position_type = PositionType.find(params[:id])

    respond_to do |format|
      if @position_type.update_attributes(params[:position_type])
        format.html { redirect_to @position_type, notice: 'Position type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @position_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /position_types/1
  # DELETE /position_types/1.json
  def destroy
    @position_type = PositionType.find(params[:id])
    @position_type.destroy

    respond_to do |format|
      format.html { redirect_to position_types_url }
      format.json { head :no_content }
    end
  end
end
