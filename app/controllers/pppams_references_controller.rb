class PppamsReferencesController < ApplicationController
  # GET /pppams_references
  # GET /pppams_references.json
  def index
    @pppams_references = PppamsReference.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pppams_references }
    end
  end

  # GET /pppams_references/1
  # GET /pppams_references/1.json
  def show
    @pppams_reference = PppamsReference.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pppams_reference }
    end
  end

  # GET /pppams_references/new
  # GET /pppams_references/new.json
  def new
    @pppams_reference = PppamsReference.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pppams_reference }
    end
  end

  # GET /pppams_references/1/edit
  def edit
    @pppams_reference = PppamsReference.find(params[:id])
  end

  # POST /pppams_references
  # POST /pppams_references.json
  def create
    @pppams_reference = PppamsReference.new(params[:pppams_reference])

    respond_to do |format|
      if @pppams_reference.save
        format.html { redirect_to @pppams_reference, notice: 'Pppams reference was successfully created.' }
        format.json { render json: @pppams_reference, status: :created, location: @pppams_reference }
      else
        format.html { render action: "new" }
        format.json { render json: @pppams_reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pppams_references/1
  # PUT /pppams_references/1.json
  def update
    @pppams_reference = PppamsReference.find(params[:id])

    respond_to do |format|
      if @pppams_reference.update_attributes(params[:pppams_reference])
        format.html { redirect_to @pppams_reference, notice: 'Pppams reference was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pppams_reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pppams_references/1
  # DELETE /pppams_references/1.json
  def destroy
    @pppams_reference = PppamsReference.find(params[:id])
    @pppams_reference.destroy

    respond_to do |format|
      format.html { redirect_to pppams_references_url }
      format.json { head :no_content }
    end
  end
end
