require File.dirname(__FILE__) + '/../spec_helper'

 describe IncidentTypesController do
   before do
     login_as_admin
   end
   describe "index" do
     describe "GET" do
       before do
         27.times {|i| IncidentType.make} 
       end
       it "should assign pagination to IncidentTypes" do
         get :index
         assigns[:incident_types].total_entries.should == 27
       end
     end
   end
 end
