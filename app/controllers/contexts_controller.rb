class ContextsController < ApplicationController
<<<<<<< HEAD
  def index
    @contexts = Context.all(:order => 'position')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contexts }
    end
  end

  # GET /contexts/1
  # GET /contexts/1.json
  def show
    @context = Context.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @context }
    end
  end

  # GET /contexts/new
  # GET /contexts/new.json
  def new
    @context = Context.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @context }
    end
  end

  # GET /contexts/1/edit
  def edit
    @context = Context.find(params[:id])
  end

  # POST /contexts
  # POST /contexts.json
  def create
    @context = Context.new(params[:context])

    respond_to do |format|
      if @context.save
        format.html { redirect_to @context, notice: 'Context was successfully created.' }
        format.json { render json: @context, status: :created, location: @context }
      else
        format.html { render action: "new" }
        format.json { render json: @context.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contexts/1
  # PUT /contexts/1.json
  def update
    @context = Context.find(params[:id])

    respond_to do |format|
      if @context.update_attributes(params[:context])
        format.html { redirect_to @context, notice: 'Context was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @context.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contexts/1
  # DELETE /contexts/1.json
  def destroy
    @context = Context.find(params[:id])
    @context.destroy

    respond_to do |format|
      format.html { redirect_to contexts_url }
      format.json { head :no_content }
=======
  
  before_filter :admin_authenticate
  layout 'administration'
  
  def index
    @contexts = Context.paginate :per_page => 10, :page => params[:page]
    @contexts_for_order = Context.find(:all, :order => 'position')
    
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @contexts.to_xml }
    end
  end
  
  def reorder_contexts
    @order = params[params[:list_name]]
    @order.each_with_index do |id, i|
      Context.update(id , {:position => i+1})             
    end
    render = false
  end
  
  # GET /contexts/1
  # GET /contexts/1.xml
  def show
    @context = Context.find(params[:id])
    
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @context.to_xml }
    end
  end
  
  # GET /contexts/new
  def new
    @context = Context.new
  end
  
  # GET /contexts/1;edit
  def edit
    @context = Context.find(params[:id])
  end
  
  # POST /contexts
  # POST /contexts.xml
  def create
    @context = Context.new(params[:context])
    
    respond_to do |format|
      if @context.save
        flash[:notice] = 'Log Category was successfully created.'
        format.html { redirect_to context_url(@context) }
        format.xml  { head :created, :location => context_url(@context) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @context.errors.to_xml }
      end
    end
  end
  
  # PUT /contexts/1
  # PUT /contexts/1.xml
  def update
    @context = Context.find(params[:id])
    
    respond_to do |format|
      if @context.update_attributes(params[:context])
        flash[:notice] = 'Log Category was successfully updated.'
        format.html { redirect_to context_url(@context) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @context.errors.to_xml }
      end
    end
  end
  
  # DELETE /contexts/1
  # DELETE /contexts/1.xml
  def destroy
    @context = Context.find(params[:id])
    @context.destroy
    
    respond_to do |format|
      format.html { redirect_to contexts_url }
      format.xml  { head :ok }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end
end
