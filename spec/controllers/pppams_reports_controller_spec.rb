require File.dirname(__FILE__) + '/../spec_helper'

def process_report(extra_params = {})
  post :filter, :report_request => 'Value', :pppams_report_filter => extra_params
end
describe PppamsReportsController do
  before(:each) do
    login_as_admin
  end
  describe "filter" do
    it "GET without params should render the filter form without any warnings" do
      controller.should_not_receive :process_a_report
      controller.should_not_receive :save_a_new_filter
      get :filter
      flash[:warning].should be_nil
      response.should render_template 'filter'
    end
    it "POST with a report request should process the report" do
      controller.should_receive(:process_a_report).and_return(true)
      controller.should_not_receive :save_a_new_filter
      post :filter, :report_request => 'random params'
    end
    it "POST with 'save a filter' option with a name should save the filter" do
      controller.should_receive(:save_a_new_filter).and_return(true)
      controller.should_not_receive :process_a_report
      post :filter, :pppams_report_filter => {:name => 'random params'}
      flash[:warning].should be_nil
    end
    it "POST with 'save a filter' option without a name should raise a warning" do
      controller.should_not_receive :save_a_new_filter
      controller.should_not_receive :process_a_report
      post :filter, :pppams_report_filter => nil
      flash[:warning].should_not be_blank
    end
    it "should accept parameters to be used in the report through the 'use_params' argument" do
      controller.send(:filter, 'hello world')
      controller.instance_variable_get(:@use_params).should == 'hello world'
    end
  end
  describe "process_a_report" do
    describe "of type 'signature'" do
      it "when more or less than one facility is selected, should render flash warning " do
        process_report({:report_type => 'signature.rhtml', :facility_filter => ['']})
        flash[:warning].should_not be_blank
      end
      it "should blank out the score_filter and other stuff"
    end
    describe "of type 'full'" do
      it '' do
        
      end
    end
    describe " of type 'summary (average)'"
    describe " of type 'summary (percentage'"
    it "should use params from the old post, when provided" #do
      #process_report
      #assigns[:use_params].should == {'report_request' => 'Value', 'pppams_report_filter' => ''}
    #end
    
  end
end
