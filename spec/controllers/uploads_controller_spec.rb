require File.dirname(__FILE__) + '/../spec_helper'

 describe UploadsController do
   before do
     login_as_admin
   end
   describe "list" do
     describe "GET" do
       before do
         f = Facility.make
         session[:facility] = f
         27.times {|i| Upload.make}
       end
       it "should assign pagination to Uploads" do
         get :list
         assigns[:uploads].total_entries.should == 27
       end
     end
   end
 end
