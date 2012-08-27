class CustodyTypesController < ApplicationController
  # GET /custody_types
  # GET /custody_types.json
  def index
    @custody_types = CustodyType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @custody_types }
    end
  end

  # GET /custody_types/1
  # GET /custody_types/1.json
  def show
    @custody_type = CustodyType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @custody_type }
    end
  end

  # GET /custody_types/new
  # GET /custody_types/new.json
  def new
    @custody_type = CustodyType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @custody_type }
    end
  end

  # GET /custody_types/1/edit
  def edit
    @custody_type = CustodyType.find(params[:id])
  end

  # POST /custody_types
  # POST /custody_types.json
  def create
    @custody_type = CustodyType.new(params[:custody_type])

    respond_to do |format|
      if @custody_type.save
        format.html { redirect_to @custody_type, notice: 'Custody type was successfully created.' }
        format.json { render json: @custody_type, status: :created, location: @custody_type }
      else
        format.html { render action: "new" }
        format.json { render json: @custody_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /custody_types/1
  # PUT /custody_types/1.json
  def update
    @custody_type = CustodyType.find(params[:id])

    respond_to do |format|
      if @custody_type.update_attributes(params[:custody_type])
        format.html { redirect_to @custody_type, notice: 'Custody type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @custody_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /custody_types/1
  # DELETE /custody_types/1.json
  def destroy
    @custody_type = CustodyType.find(params[:id])
    @custody_type.destroy

    respond_to do |format|
      format.html { redirect_to custody_types_url }
      format.json { head :no_content }
    end
  end
end
