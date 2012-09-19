require 'spec_helper'

describe PppamsCategoryBaseRefsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/pppams_category_base_refs" }.should route_to(:controller => "pppams_category_base_refs", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/pppams_category_base_refs/new" }.should route_to(:controller => "pppams_category_base_refs", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/pppams_category_base_refs/1" }.should route_to(:controller => "pppams_category_base_refs", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/pppams_category_base_refs/1/edit" }.should route_to(:controller => "pppams_category_base_refs", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/pppams_category_base_refs" }.should route_to(:controller => "pppams_category_base_refs", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/pppams_category_base_refs/1" }.should route_to(:controller => "pppams_category_base_refs", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/pppams_category_base_refs/1" }.should route_to(:controller => "pppams_category_base_refs", :action => "destroy", :id => "1") 
    end
  end
end
