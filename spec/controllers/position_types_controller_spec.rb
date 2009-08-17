require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'ruby-debug'
describe PositionTypesController do
  integrate_views
  def mock_position_type(stubs={})
    #debugger
    @mock_position_type ||= (stubs.empty? ? PositionType.make : mock_model(PositionType, stubs))
  end
  
  before do
    @admin = User.make(:administrator)
    login_as @admin
    session[:facility]= mock_position_type.facility

  end
  describe "GET index" do
    it "assigns all position_types as @position_types" do
      PositionType.stub!(:find).and_return([mock_position_type])
      get :index
      assigns[:position_types].should == [mock_position_type]
    end
  end

  describe "GET show" do
    it "assigns the requested position_type as @position_type" do
      PositionType.stub!(:find).with("37").and_return(mock_position_type)
      get :show, :id => "37"
      assigns[:position_type].should equal(mock_position_type)
    end
  end

  describe "GET new" do
    it "assigns a new position_type as @position_type" do
      PositionType.stub!(:new).and_return(mock_position_type)
      get :new
      assigns[:position_type].should equal(mock_position_type)
    end
  end

  describe "GET edit" do
    it "assigns the requested position_type as @position_type" do
      PositionType.stub!(:find).with("37").and_return(mock_position_type)
      get :edit, :id => "37"
      assigns[:position_type].should equal(mock_position_type)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created position_type as @position_type" do
        PositionType.stub!(:new).with({'these' => 'params'}).and_return(mock_position_type(:save => true))
        post :create, :position_type => {:these => 'params'}
        assigns[:position_type].should equal(mock_position_type)
      end

      it "redirects to the created position_type" do
        PositionType.stub!(:new).and_return(mock_position_type(:save => true))
        post :create, :position_type => {}
        response.should redirect_to(position_type_url(mock_position_type))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved position_type as @position_type" do
        PositionType.stub!(:new).with({'these' => 'params'}).and_return(mock_position_type(:save => false))
        post :create, :position_type => {:these => 'params'}
        assigns[:position_type].should equal(mock_position_type)
      end

    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested position_type" do
        PositionType.should_receive(:find).with("37").and_return(mock_position_type)
        mock_position_type.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :position_type => {:these => 'params'}
      end

      it "assigns the requested position_type as @position_type" do
        PositionType.stub!(:find).and_return(mock_position_type(:update_attributes => true))
        put :update, :id => "1"
        assigns[:position_type].should equal(mock_position_type)
      end

      it "redirects to the position_type" do
        PositionType.stub!(:find).and_return(mock_position_type(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(position_type_url(mock_position_type))
      end
    end

    describe "with invalid params" do
      it "updates the requested position_type" do
        PositionType.should_receive(:find).with("37").and_return(mock_position_type)
        mock_position_type.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :position_type => {:these => 'params'}
      end

      it "assigns the position_type as @position_type" do
        PositionType.stub!(:find).and_return(mock_position_type(:update_attributes => false))
        put :update, :id => "1"
        assigns[:position_type].should equal(mock_position_type)
      end

    end

  end

  describe "DELETE destroy" do
    it "destroys the requested position_type" do
      PositionType.should_receive(:find).with("37").and_return(mock_position_type)
      mock_position_type.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the position_types list" do
      PositionType.stub!(:find).and_return(mock_position_type(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(position_types_url)
    end
  end

end
