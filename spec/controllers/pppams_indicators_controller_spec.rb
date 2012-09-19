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
    describe "GET new" do
      it "should expose a new indicator with the base and facility_id" do
        PppamsIndicatorBaseRef.should_receive(:find).and_return(mock_model(PppamsIndicatorBaseRef,:id => 23))
        Facility.should_receive(:find).and_return(mock_model(Facility, :id => 54))

        get :new, :pppams_indicator_base_ref_id => '23', :facility_id => '54'
        assigns[:pppams_indicator].pppams_indicator_base_ref_id.should == 23
        assigns[:pppams_indicator].facility_id.should == 54
      end
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
      describe "bulk_update" do
        def do_put_bulk_update
          put :bulk_update, :pppams_review_selector => ['1', '2'], :pppams_review_bulk_note => 'some note',
                                                                   :pppams_review_new_status => 'new_status'
        end
        it "should find and assign all of the selected reviews to their new notes and statuses" do
          PppamsReview.should_receive(:find).with('1').and_return(mock_model(PppamsReview, 'status=' => 1, 'notes=' => nil, 'notes' => nil, :save => true))
          PppamsReview.should_receive(:find).with('2').and_return(mock_model(PppamsReview, 'status=' => 1, 'notes=' => nil, 'notes' => nil, :save => true))
          do_put_bulk_update
        end
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
