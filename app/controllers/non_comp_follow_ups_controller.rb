class NonCompFollowUpsController < ApplicationController
  # GET /non_comp_follow_ups
  # GET /non_comp_follow_ups.json
  def index
    @non_comp_follow_ups = NonCompFollowUp.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @non_comp_follow_ups }
    end
  end

  # GET /non_comp_follow_ups/1
  # GET /non_comp_follow_ups/1.json
  def show
    @non_comp_follow_up = NonCompFollowUp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @non_comp_follow_up }
    end
  end

  # GET /non_comp_follow_ups/new
  # GET /non_comp_follow_ups/new.json
  def new
    @non_comp_follow_up = NonCompFollowUp.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @non_comp_follow_up }
    end
  end

  # GET /non_comp_follow_ups/1/edit
  def edit
    @non_comp_follow_up = NonCompFollowUp.find(params[:id])
  end

  # POST /non_comp_follow_ups
  # POST /non_comp_follow_ups.json
  def create
    @non_comp_follow_up = NonCompFollowUp.new(params[:non_comp_follow_up])

    respond_to do |format|
      if @non_comp_follow_up.save
        format.html { redirect_to @non_comp_follow_up, notice: 'Non comp follow up was successfully created.' }
        format.json { render json: @non_comp_follow_up, status: :created, location: @non_comp_follow_up }
      else
        format.html { render action: "new" }
        format.json { render json: @non_comp_follow_up.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /non_comp_follow_ups/1
  # PUT /non_comp_follow_ups/1.json
  def update
    @non_comp_follow_up = NonCompFollowUp.find(params[:id])

    respond_to do |format|
      if @non_comp_follow_up.update_attributes(params[:non_comp_follow_up])
        format.html { redirect_to @non_comp_follow_up, notice: 'Non comp follow up was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @non_comp_follow_up.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /non_comp_follow_ups/1
  # DELETE /non_comp_follow_ups/1.json
  def destroy
    @non_comp_follow_up = NonCompFollowUp.find(params[:id])
    @non_comp_follow_up.destroy

    respond_to do |format|
      format.html { redirect_to non_comp_follow_ups_url }
      format.json { head :no_content }
    end
  end
end
