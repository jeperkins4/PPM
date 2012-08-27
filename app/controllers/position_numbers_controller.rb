class PositionNumbersController < ApplicationController
  expose(:position_numbers) { PositionNumber.all.order(:position_num) }
  expose(:position_number)

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: PositionNumbersDatatable.new(view_context) }
    end
  end

  def show
    @position_number = PositionNumber.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @position_number }
    end
  end

  # GET /position_numbers/new
  # GET /position_numbers/new.json
  def new
    @position_number = PositionNumber.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @position_number }
    end
  end

  # GET /position_numbers/1/edit
  def edit
    @position_number = PositionNumber.find(params[:id])
  end

  # POST /position_numbers
  # POST /position_numbers.json
  def create
    @position_number = PositionNumber.new(params[:position_number])

    respond_to do |format|
      if @position_number.save
        format.html { redirect_to @position_number, notice: 'Position number was successfully created.' }
        format.json { render json: @position_number, status: :created, location: @position_number }
      else
        format.html { render action: "new" }
        format.json { render json: @position_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /position_numbers/1
  # PUT /position_numbers/1.json
  def update
    @position_number = PositionNumber.find(params[:id])

    respond_to do |format|
      if @position_number.update_attributes(params[:position_number])
        format.html { redirect_to @position_number, notice: 'Position number was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @position_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /position_numbers/1
  # DELETE /position_numbers/1.json
  def destroy
    @position_number = PositionNumber.find(params[:id])
    @position_number.destroy

    respond_to do |format|
      format.html { redirect_to position_numbers_url }
      format.json { head :no_content }
    end
  end
end
