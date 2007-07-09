class InvestigatorsController < ApplicationController
  layout 'administration'
  # GET /investigators.xml
  def index
    @investigators = Investigator.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @investigators.to_xml }
    end
  end

  # GET /investigators/1
  # GET /investigators/1.xml
  def show
    @investigator = Investigator.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @investigator.to_xml }
    end
  end

  # GET /investigators/new
  def new
    @investigator = Investigator.new
  end

  # GET /investigators/1;edit
  def edit
    @investigator = Investigator.find(params[:id])
  end

  # POST /investigators
  # POST /investigators.xml
  def create
    @investigator = Investigator.new(params[:investigator])

    respond_to do |format|
      if @investigator.save
        flash[:notice] = 'Investigator was successfully created.'
        format.html { redirect_to investigator_url(@investigator) }
        format.xml  { head :created, :location => investigator_url(@investigator) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @investigator.errors.to_xml }
      end
    end
  end

  # PUT /investigators/1
  # PUT /investigators/1.xml
  def update
    @investigator = Investigator.find(params[:id])

    respond_to do |format|
      if @investigator.update_attributes(params[:investigator])
        flash[:notice] = 'Investigator was successfully updated.'
        format.html { redirect_to investigator_url(@investigator) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @investigator.errors.to_xml }
      end
    end
  end

  # DELETE /investigators/1
  # DELETE /investigators/1.xml
  def destroy
    @investigator = Investigator.find(params[:id])
    @investigator.destroy

    respond_to do |format|
      format.html { redirect_to investigators_url }
      format.xml  { head :ok }
    end
  end
end
