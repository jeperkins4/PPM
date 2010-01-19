require File.dirname(__FILE__) + '/../spec_helper'

describe PppamsIndicatorsController do
  def mock_indicator(stubs = {})
    @mock_indicator ||= mock_model(PppamsIndicator, {:start_month => 1,
                                                     :good_months => ':1:',
                                                     :frequency => 1,
                                                     :pppams_indicator_base_ref_id => 3,
                                                     :facility_id => 5,
                                                     :id => 12
                                                    }.merge(stubs))
  end
  describe "When logged in as admin" do
    before do
      login_as_admin
    end
    describe "GET edit" do
      it "should expose the pppams_indicator" do
        PppamsIndicator.should_receive(:find).with('12').and_return(mock_indicator)
        get :edit, :id => '12'
        assigns[:pppams_indicator].should == mock_indicator
      end
    end
    describe "GET show" do
      it "should expose the requested indicator" do
        PppamsIndicator.should_receive(:find).with('12').and_return(mock_indicator)
        get :show, :id => '12'
      end
    end
    describe "PUT update" do
      it "should expose the indicator and update the good months" do
        PppamsIndicator.should_receive(:find).with('12').and_return(mock_indicator)
        mock_indicator.should_receive(:update_good_months).with('2','2').and_return(true)
        mock_indicator.should_receive(:update_attributes).and_return(true)
        post :update, :id => '12', :pppams_indicator => {:start_month => '2', :frequency => '2'}
      end
    end
    describe "actions requiring a facility" do
      before do
        session[:facility] = mock_model(Facility, :id => 1)
      end
      describe "GET index" do
        it 'runs and renders the list action' do
          controller.should_receive :list
          get :index
          response.should render_template 'pppams_indicators/list'
        end
      end
      describe "GET list" do
        it "should expose the current facility's indicators" do
          
          get :list
          response.should render_template 'pppams_indicators/list'
        end
      end
      describe "editable_list" do
        it "should handle the new indicator relations" 
      end
      describe "_to_do" do
        it "should handle the new indicator relations"
      end
      describe "_editable_to_do" do
        it "should handle the new indicator relations"
      end
      describe "bulk_update" do
        it "should handle the new indicator relations"
      end
    end
  end
  describe "GET edit without being logged in as admin" do
    it "should expose the pppams_indicator" do
      PppamsIndicator.should_not_receive(:find).with('12').and_return(mock_indicator)
      get :edit, :id => '12'
      response.should be_redirect
    end
  end
end
