require File.dirname(__FILE__) + '/../spec_helper'

 describe NonCompIssuesController do
   before do
     login_as_admin
   end
   describe "index" do
     describe "GET" do
       before do
         session[:facility] = Facility.make
         27.times {|i| NonCompIssue.make(:facility => session[:facility])}
       end
       it "should assign pagination to NonCompIssues" do
         get :index
         assigns[:non_comp_issues].total_entries.should == 27
       end
     end
   end
 end
