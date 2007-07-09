class ActionTypesController < ApplicationController
  layout 'administration'
  # GET /action_types.xml
  def index
    @action_types = ActionType.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @action_types.to_xml }
    end
  end

  # GET /action_types/1
  # GET /action_types/1.xml
  def show
    @action_type = ActionType.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @action_type.to_xml }
    end
  end

  # GET /action_types/new
  def new
    @action_type = ActionType.new
  end

  # GET /action_types/1;edit
  def edit
    @action_type = ActionType.find(params[:id])
  end

  # POST /action_types
  # POST /action_types.xml
  def create
    @action_type = ActionType.new(params[:action_type])

    respond_to do |format|
      if @action_type.save
        flash[:notice] = 'ActionType was successfully created.'
        format.html { redirect_to action_type_url(@action_type) }
        format.xml  { head :created, :location => action_type_url(@action_type) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @action_type.errors.to_xml }
      end
    end
  end

  # PUT /action_types/1
  # PUT /action_types/1.xml
  def update
    @action_type = ActionType.find(params[:id])

    respond_to do |format|
      if @action_type.update_attributes(params[:action_type])
        flash[:notice] = 'ActionType was successfully updated.'
        format.html { redirect_to action_type_url(@action_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @action_type.errors.to_xml }
      end
    end
  end

  # DELETE /action_types/1
  # DELETE /action_types/1.xml
  def destroy
    @action_type = ActionType.find(params[:id])
    @action_type.destroy

    respond_to do |format|
      format.html { redirect_to action_types_url }
      format.xml  { head :ok }
    end
  end
end
