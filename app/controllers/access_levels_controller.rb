class AccessLevelsController < ApplicationController
  # GET /access_levels
  # GET /access_levels.json
  def index
    @access_levels = AccessLevel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @access_levels }
    end
  end

  # GET /access_levels/1
  def show
    @access_level = AccessLevel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @access_level }
    end
  end

  # GET /access_levels/new
  def new
    @access_level = AccessLevel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @access_level }
    end
  end

  # GET /access_levels/1/edit
  def edit
    @access_level = AccessLevel.find(params[:id])
  end

  def create
    @access_level = AccessLevel.new(params[:access_level])

    respond_to do |format|
      if @access_level.save
        format.html { redirect_to @access_level, notice: 'Access level was successfully created.' }
        format.json { render json: @access_level, status: :created, location: @access_level }
      else
        format.html { render action: "new" }
        format.json { render json: @access_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /access_levels/1
  def update
    @access_level = AccessLevel.find(params[:id])

    respond_to do |format|
      if @access_level.update_attributes(params[:access_level])
        format.html { redirect_to @access_level, notice: 'Access level was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @access_level.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @access_level = AccessLevel.find(params[:id])
    @access_level.destroy

    respond_to do |format|
      format.html { redirect_to access_levels_url }
      format.json { head :no_content }
    end
  end
end
