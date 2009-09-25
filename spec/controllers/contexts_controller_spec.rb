 require File.dirname(__FILE__) + '/../spec_helper'

 describe ContextsController do
   before do
     login_helper
   end
   describe "index" do
     describe "GET" do
       before do
         f = Facility.make
         session[:facility] = f
         27.times {|i| Context.make }
       end
       it "should assign pagination to Contexts" do
         get :index
         assigns[:contexts].total_entries.should == 27
       end
     end
   end
 end
