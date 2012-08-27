class PppamsCategoryGroupsController < ApplicationController
  # GET /pppams_category_groups
  # GET /pppams_category_groups.json
  def index
    @pppams_category_groups = PppamsCategoryGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pppams_category_groups }
    end
  end

  # GET /pppams_category_groups/1
  # GET /pppams_category_groups/1.json
  def show
    @pppams_category_group = PppamsCategoryGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pppams_category_group }
    end
  end

  # GET /pppams_category_groups/new
  # GET /pppams_category_groups/new.json
  def new
    @pppams_category_group = PppamsCategoryGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pppams_category_group }
    end
  end

  # GET /pppams_category_groups/1/edit
  def edit
    @pppams_category_group = PppamsCategoryGroup.find(params[:id])
  end

  # POST /pppams_category_groups
  # POST /pppams_category_groups.json
  def create
    @pppams_category_group = PppamsCategoryGroup.new(params[:pppams_category_group])

    respond_to do |format|
      if @pppams_category_group.save
        format.html { redirect_to @pppams_category_group, notice: 'Pppams category group was successfully created.' }
        format.json { render json: @pppams_category_group, status: :created, location: @pppams_category_group }
      else
        format.html { render action: "new" }
        format.json { render json: @pppams_category_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pppams_category_groups/1
  # PUT /pppams_category_groups/1.json
  def update
    @pppams_category_group = PppamsCategoryGroup.find(params[:id])

    respond_to do |format|
      if @pppams_category_group.update_attributes(params[:pppams_category_group])
        format.html { redirect_to @pppams_category_group, notice: 'Pppams category group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pppams_category_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pppams_category_groups/1
  # DELETE /pppams_category_groups/1.json
  def destroy
    @pppams_category_group = PppamsCategoryGroup.find(params[:id])
    @pppams_category_group.destroy

    respond_to do |format|
      format.html { redirect_to pppams_category_groups_url }
      format.json { head :no_content }
    end
  end
end
