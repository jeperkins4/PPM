class NonCompIssuesController < ApplicationController
  # GET /non_comp_issues
  # GET /non_comp_issues.json
  def index
    @non_comp_issues = NonCompIssue.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @non_comp_issues }
    end
  end

  # GET /non_comp_issues/1
  # GET /non_comp_issues/1.json
  def show
    @non_comp_issue = NonCompIssue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @non_comp_issue }
    end
  end

  # GET /non_comp_issues/new
  # GET /non_comp_issues/new.json
  def new
    @non_comp_issue = NonCompIssue.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @non_comp_issue }
    end
  end

  # GET /non_comp_issues/1/edit
  def edit
    @non_comp_issue = NonCompIssue.find(params[:id])
  end

  # POST /non_comp_issues
  # POST /non_comp_issues.json
  def create
    @non_comp_issue = NonCompIssue.new(params[:non_comp_issue])

    respond_to do |format|
      if @non_comp_issue.save
        format.html { redirect_to @non_comp_issue, notice: 'Non comp issue was successfully created.' }
        format.json { render json: @non_comp_issue, status: :created, location: @non_comp_issue }
      else
        format.html { render action: "new" }
        format.json { render json: @non_comp_issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /non_comp_issues/1
  # PUT /non_comp_issues/1.json
  def update
    @non_comp_issue = NonCompIssue.find(params[:id])

    respond_to do |format|
      if @non_comp_issue.update_attributes(params[:non_comp_issue])
        format.html { redirect_to @non_comp_issue, notice: 'Non comp issue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @non_comp_issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /non_comp_issues/1
  # DELETE /non_comp_issues/1.json
  def destroy
    @non_comp_issue = NonCompIssue.find(params[:id])
    @non_comp_issue.destroy

    respond_to do |format|
      format.html { redirect_to non_comp_issues_url }
      format.json { head :no_content }
    end
  end
end
