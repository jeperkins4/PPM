class ReportsController < ApplicationController

  layout 'administration'

  def index
   @incidents = Incident.find(:all)
   if @request.post?
     @test = params[:incident][:begin_date]
     render :text => 'test'
   @incidents = Incident.find(:all, :conditions => ["incident_date > ?", params[:incident][:begin_date]])     
   end
  end
  
end
