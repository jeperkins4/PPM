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
      controller.send(:filter, {:a => 'hello world'})
      controller.instance_variable_get(:@use_params)[:a].should == 'hello world'
    end
  end
  describe "process_a_report" do
    it "should create signature reports" do
      controller.should_receive(:create_signature_report).and_return(false)
      process_report({:report_type => 'signature'})
    end
    it "should create summary_average reports" do
      controller.should_receive(:create_summary_average_report).and_return(false)
      process_report({:report_type => 'summary_average'})
    end
    it "should create summary_percent reports" do
      controller.should_receive(:create_summary_percent_report).and_return(false)
      process_report({:report_type => 'summary_percent'})
    end
  end
  describe "signature reports" do
    describe "when more or less than one facility is selected" do
      it "should render flash warning " do
        process_report({:report_type => 'signature', :facility_filter => ['']})
        flash[:warning].should_not be_blank
      end
      it "should assign facilities" do
        Facility.should_receive(:find).with(:all).and_return(['a'])
        process_report({:report_type => 'signature', :facility_filter => ['']})
        assigns[:facilities].should == ['a']
      end
      it "should assign cats" do
        PppamsCategoryBaseRef.should_receive(:find).with(:all, :order => :name).and_return(['b'])
        process_report({:report_type => 'signature', :facility_filter => ['']})
        assigns[:Cats].should == ['b']
      end
    end
    describe "when one facility is provided" do
      before(:each) do
        @valid_params = {
                         :report_type => 'signature',
                         :facility_filter => ['16'],
                         :start_date => 'January 1, 2009',
                         :end_date => 'January 1, 2009'
                        }
        Facility.stub!(:find => stub(:id => 16))
        PppamsCategoryBaseRef.stub!(:signature_summary_for_facility => {23 => 1, 24 => 2, :hello => 'other'})
      end
      it 'should find and assign the facility' do
        process_report(@valid_params)
        assigns[:facility].id.should == 16
      end
      it 'should find and assign the from date' do
        process_report(@valid_params)
        assigns[:show_from].to_date.should == Date.new(2009,1,1)
      end
      it 'should find and assign the to date as the end of the month of the from date' do
        process_report(@valid_params)
        assigns[:show_to].to_date.should == Date.new(2009,1,31)
      end
      it 'should assign left and right groups, ignoring non-"id" hash keys' do
        process_report(@valid_params)
        assigns[:left_side_groups].should have(1).record
        assigns[:right_side_groups].should have(1).record
      end
      it 'should render the signature action' do
        process_report(@valid_params)
        response.should render_template('signature')
      end
    end
  end
  describe "'summary (average)'" do
    before(:each) do
      @valid_params = {:report_type => 'summary_average',
                       :start_date  => 'January 1, 2009',
                       :end_date    => 'March 30, 2009'}
    end
    describe "when the user selects one facility" do
      before(:each) do
        @valid_params.merge!({:facility_filter => ['5']})
      end
      describe "with one or multiple indicators" do
        it "should show the category name for that indicator" do
          process_report(@valid_params.merge({:indicator_filter => ['5'] }))
        end
      end
    end
  end
end
