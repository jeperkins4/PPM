class PromptsController < ApplicationController
  
  before_filter :admin_authenticate
  layout 'administration'
  
  def index
    @prompt_pages, @prompts = paginate :prompts
    #@prompts = Prompt.find(:all)
    
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @prompts.to_xml }
    end
  end
  
  # GET /prompts/1
  # GET /prompts/1.xml
  def show
    @prompt = Prompt.find(params[:id])
    
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @prompt.to_xml }
    end
  end
  
  # GET /prompts/new
  def new
    @prompt = Prompt.new
  end
  
  # GET /prompts/1;edit
  def edit
    @prompt = Prompt.find(params[:id])
  end
  
  # POST /prompts
  # POST /prompts.xml
  def create
    @prompt = Prompt.new(params[:prompt])
    
    respond_to do |format|
      if @prompt.save
        flash[:notice] = 'Prompt was successfully created.'
        format.html { redirect_to prompt_url(@prompt) }
        format.xml  { head :created, :location => prompt_url(@prompt) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @prompt.errors.to_xml }
      end
    end
  end
  
  # PUT /prompts/1
  # PUT /prompts/1.xml
  def update
    @prompt = Prompt.find(params[:id])    
    @records_update = AccountabilityLogs.find_all_by_context_id_and_prompt_id(@prompt.context_id, @prompt.id)        
    respond_to do |format|     
      if @prompt.update_attributes(params[:prompt])
        update_contexts(@records_update, @prompt)
        flash[:notice] = 'Prompt was successfully updated.'
        format.html { redirect_to prompt_url(@prompt) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prompt.errors.to_xml }          
      end
    end      
  end
  
  # DELETE /prompts/1
  # DELETE /prompts/1.xml
  def destroy
    @prompt = Prompt.find(params[:id])
    @prompt.destroy
    
    respond_to do |format|
      format.html { redirect_to prompts_url }
      format.xml  { head :ok }
    end
  end
  
  def update_contexts(rows, update_object)
    rows.each do |r|
      r.update_attribute('context_id',update_object.context_id)      
    end
  end
  
end
