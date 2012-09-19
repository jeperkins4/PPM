require 'spec_helper'

describe PppamsReferencesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/pppams_references" }.should route_to(:controller => "pppams_references", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/pppams_references/new" }.should route_to(:controller => "pppams_references", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/pppams_references/1" }.should route_to(:controller => "pppams_references", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/pppams_references/1/edit" }.should route_to(:controller => "pppams_references", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/pppams_references" }.should route_to(:controller => "pppams_references", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/pppams_references/1" }.should route_to(:controller => "pppams_references", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/pppams_references/1" }.should route_to(:controller => "pppams_references", :action => "destroy", :id => "1") 
    end
  end
end
