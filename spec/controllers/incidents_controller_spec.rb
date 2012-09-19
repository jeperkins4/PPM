 require File.dirname(__FILE__) + '/../spec_helper'

 describe IncidentsController do
   before do
     login_as_admin
   end
   describe "index" do
     describe "GET" do
       before do
         f = Facility.make
         session[:facility] = f
         27.times {|i| Incident.make(:facility => f, :investigation_closed => 0) }
       end
       it "should assign pagination to Incidents" do
         get :index
         assigns[:incidents].total_entries.should == 27
       end
     end
   end
 end
