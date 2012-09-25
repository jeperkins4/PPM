class CustodyTypesController < ApplicationController

  #expose(:custody_types) { CustodyType.all }
  #expose(:custody_type)

  def index
    @custody_types = CustodyType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @custody_types }
    end
  end

  def show
    @custody_type = CustodyType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @custody_type }
    end
  end

  def new
    @custody_type = CustodyType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @custody_type }
    end
  end

  def edit
    @custody_type = CustodyType.find(params[:id])
  end

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

  def destroy
    @custody_type = CustodyType.find(params[:id])
    @custody_type.destroy

    respond_to do |format|
      format.html { redirect_to custody_types_url }
      format.json { head :no_content }
    end
  end
end
