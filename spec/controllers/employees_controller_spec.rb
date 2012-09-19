require File.dirname(__FILE__) + '/../spec_helper'

 describe EmployeesController do
   before do
     login_as_admin
   end
   describe "index" do
     describe "GET" do
       before do
         f = Facility.make
         session[:facility] = f
         27.times {|i| Employee.make(:facility => f)} 
       end
       it "should assign pagination to Employees" do
         get :index
         assigns[:employees].total_entries.should == 27
       end
     end
   end
 end
