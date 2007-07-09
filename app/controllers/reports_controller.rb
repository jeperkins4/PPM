class ReportsController < ApplicationController

  layout 'administration'

  def index
   @incidents = Incident.find(:all)
  end
  
end
