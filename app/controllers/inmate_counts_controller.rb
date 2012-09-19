<<<<<<< HEAD
class InmateCountsController < ApplicationController
  # GET /inmate_counts
  # GET /inmate_counts.json
  def index
    @inmate_counts = InmateCount.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inmate_counts }
    end
  end

  # GET /inmate_counts/1
  # GET /inmate_counts/1.json
  def show
    @inmate_count = InmateCount.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inmate_count }
    end
  end

  # GET /inmate_counts/new
  # GET /inmate_counts/new.json
  def new
    @inmate_count = InmateCount.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inmate_count }
    end
  end

  # GET /inmate_counts/1/edit
  def edit
    @inmate_count = InmateCount.find(params[:id])
  end

  # POST /inmate_counts
  # POST /inmate_counts.json
  def create
    @inmate_count = InmateCount.new(params[:inmate_count])

    respond_to do |format|
      if @inmate_count.save
        format.html { redirect_to @inmate_count, notice: 'Inmate count was successfully created.' }
        format.json { render json: @inmate_count, status: :created, location: @inmate_count }
      else
        format.html { render action: "new" }
        format.json { render json: @inmate_count.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inmate_counts/1
  # PUT /inmate_counts/1.json
  def update
    @inmate_count = InmateCount.find(params[:id])

    respond_to do |format|
      if @inmate_count.update_attributes(params[:inmate_count])
        format.html { redirect_to @inmate_count, notice: 'Inmate count was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inmate_count.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inmate_counts/1
  # DELETE /inmate_counts/1.json
  def destroy
    @inmate_count = InmateCount.find(params[:id])
    @inmate_count.destroy

    respond_to do |format|
      format.html { redirect_to inmate_counts_url }
      format.json { head :no_content }
    end
  end
end
=======
class InmateCountsController < ApplicationController
  
  before_filter :authenticate
  layout 'administration'
  
  def index
    @inmate_counts = session[:facility].inmate_counts.find(:all)
    
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @inmate_counts.to_xml }
    end
  end
  
  # GET /inmate_counts/1
  # GET /inmate_counts/1.xml
  def show
    @inmate_count = InmateCount.find(params[:id])
    
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @inmate_count.to_xml }
    end
  end
  
  # GET /inmate_counts/new
  def new
    @custody_types = CustodyType.find(:all)
    @inmate_count = session[:facility].inmate_counts.new
  end
  
  # GET /inmate_counts/1;edit
  def edit
    @inmate_count = InmateCount.find(params[:id])
  end
  
  # POST /inmate_counts
  # POST /inmate_counts.xml
  def create
    @custody_types = CustodyType.find(:all)
    params[:custody_types].each_pair do |custody_type, count|
      @inmate_count = InmateCount.create(:facility_id     => session[:facility].id,
                                         :inmate_count    => (count != '') ? count : 0,
                                         :custody_type_id => custody_type,
                                         :date_collected  => Time.now()
      )  
    end
    flash[:notice] = 'Inmate count(s) were successfully recorded.'
    redirect_to inmate_counts_path
  end
  
  # PUT /inmate_counts/1
  # PUT /inmate_counts/1.xml
  def update
    @inmate_count = InmateCount.find(params[:id])
    
    respond_to do |format|
      if @inmate_count.update_attributes(params[:inmate_count])
        flash[:notice] = 'InmateCount was successfully updated.'
        format.html { redirect_to inmate_count_url(@inmate_count) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @inmate_count.errors.to_xml }
      end
    end
  end
  
  # DELETE /inmate_counts/1
  # DELETE /inmate_counts/1.xml
  def destroy
    @inmate_count = InmateCount.find(params[:id])
    @inmate_count.destroy
    
    respond_to do |format|
      format.html { redirect_to inmate_counts_url }
      format.xml  { head :ok }
    end
  end
end
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
