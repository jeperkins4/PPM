class PppamsReviewsController < ApplicationController
  # GET /pppams_reviews
  # GET /pppams_reviews.json
  def index
    @pppams_reviews = PppamsReview.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pppams_reviews }
    end
  end

  # GET /pppams_reviews/1
  # GET /pppams_reviews/1.json
  def show
    @pppams_review = PppamsReview.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pppams_review }
    end
  end

  # GET /pppams_reviews/new
  # GET /pppams_reviews/new.json
  def new
    @pppams_review = PppamsReview.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pppams_review }
    end
  end

  # GET /pppams_reviews/1/edit
  def edit
    @pppams_review = PppamsReview.find(params[:id])
  end

  # POST /pppams_reviews
  # POST /pppams_reviews.json
  def create
    @pppams_review = PppamsReview.new(params[:pppams_review])

    respond_to do |format|
      if @pppams_review.save
        format.html { redirect_to @pppams_review, notice: 'Pppams review was successfully created.' }
        format.json { render json: @pppams_review, status: :created, location: @pppams_review }
      else
        format.html { render action: "new" }
        format.json { render json: @pppams_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pppams_reviews/1
  # PUT /pppams_reviews/1.json
  def update
    @pppams_review = PppamsReview.find(params[:id])

    respond_to do |format|
      if @pppams_review.update_attributes(params[:pppams_review])
        format.html { redirect_to @pppams_review, notice: 'Pppams review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pppams_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pppams_reviews/1
  # DELETE /pppams_reviews/1.json
  def destroy
    @pppams_review = PppamsReview.find(params[:id])
    @pppams_review.destroy

    respond_to do |format|
      format.html { redirect_to pppams_reviews_url }
      format.json { head :no_content }
    end
  end
end
