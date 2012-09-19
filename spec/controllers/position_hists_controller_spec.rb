require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PositionHistsController do

  def mock_position_hist(stubs={})
    @mock_position_hist ||= (stubs.empty? ? PositionHist.make : mock_model(PositionHist, stubs))
  end
  
  before do
    @admin = User.make(:administrator)
    login_as @admin
    session[:facility]= mock_position_hist.position.position_type.facility
  end
  describe "GET index" do
    it "assigns all position_hists as @position_hists" do
      PositionHist.stub!(:find).and_return([mock_position_hist])
      get :index
      assigns[:position_hists].should == [mock_position_hist]
      response.should be_success
    end
  end

  describe "GET show" do
    it "assigns the requested position_hist as @position_hist" do
      PositionHist.stub!(:find).with("37").and_return(mock_position_hist)
      get :show, :id => "37"
      assigns[:position_hist].should equal(mock_position_hist)
      response.should be_success
    end
  end

  describe "GET new" do
    it "assigns a new position_hist as @position_hist" do
      PositionHist.stub!(:new).and_return(mock_position_hist)
      get :new
      assigns[:position_hist].should equal(mock_position_hist)
      response.should be_success
    end
  end

  describe "GET edit" do
    it "assigns the requested position_hist as @position_hist" do
      PositionHist.stub!(:find).with("37").and_return(mock_position_hist)
      get :edit, :id => "37"
      assigns[:position_hist].should equal(mock_position_hist)
      response.should be_success
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created position_hist as @position_hist" do
        PositionHist.stub!(:new).with({'these' => 'params'}).and_return(mock_position_hist(:save => true))
        post :create, :position_hist => {:these => 'params'}
        assigns[:position_hist].should equal(mock_position_hist)
      end

      it "redirects to the created position_hist" do
        PositionHist.stub!(:new).and_return(mock_position_hist(:save => true))
        post :create, :position_hist => {}
        response.should redirect_to(position_hist_url(mock_position_hist)) do
          response.should be_success
        end
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved position_hist as @position_hist" do
        PositionHist.stub!(:new).with({'these' => 'params'}).and_return(mock_position_hist(:save => false))
        post :create, :position_hist => {:these => 'params'}
        assigns[:position_hist].should equal(mock_position_hist)
        response.should redirect_to position_hist_url(mock_position_hist) do
          response.should be_success
        end
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested position_hist" do
        PositionHist.should_receive(:find).with("37").and_return(mock_position_hist)
        mock_position_hist.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :position_hist => {:these => 'params'}
        response.should be_success
      end

      it "assigns the requested position_hist as @position_hist" do
        PositionHist.stub!(:find).and_return(mock_position_hist(:update_attributes => true))
        put :update, :id => "1"
        assigns[:position_hist].should equal(mock_position_hist)
      end

      it "redirects to the position_hist" do
        PositionHist.stub!(:find).and_return(mock_position_hist(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(position_hist_url(mock_position_hist)) do
          response.should be_success
        end
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested position_hist" do
      PositionHist.should_receive(:find).with("37").and_return(mock_position_hist)
      mock_position_hist.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the position_hists list" do
      PositionHist.stub!(:find).and_return(mock_position_hist(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(position_hists_url) do
        response.should be_success
      end
    end
  end

end
