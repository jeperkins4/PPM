require 'spec_helper'

describe PppamsReferencesController do
  before(:each) do
    login_as_admin
  end
  def mock_pppams_reference(stubs={})
    @mock_pppams_reference ||= mock_model(PppamsReference, stubs)
  end

  describe "GET index" do
    it "assigns all pppams_references as @pppams_references" do
      PppamsReference.stub!(:paginate).with(:all, :per_page => 50, :page => nil, :order => 'name').and_return([mock_pppams_reference])
      get :index
      assigns[:pppams_references].should == [mock_pppams_reference]
    end
  end

  describe "GET show" do
    it "assigns the requested pppams_reference as @pppams_reference" do
      PppamsReference.stub!(:find).with("37").and_return(mock_pppams_reference)
      get :show, :id => "37"
      assigns[:pppams_reference].should equal(mock_pppams_reference)
    end
  end

  describe "GET new" do
    it "assigns a new pppams_reference as @pppams_reference" do
      PppamsReference.stub!(:new).and_return(mock_pppams_reference)
      get :new
      assigns[:pppams_reference].should equal(mock_pppams_reference)
    end
  end

  describe "GET edit" do
    it "assigns the requested pppams_reference as @pppams_reference" do
      PppamsReference.stub!(:find).with("37").and_return(mock_pppams_reference)
      get :edit, :id => "37"
      assigns[:pppams_reference].should equal(mock_pppams_reference)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created pppams_reference as @pppams_reference" do
        PppamsReference.stub!(:new).with({'these' => 'params'}).and_return(mock_pppams_reference(:save => true))
        post :create, :pppams_reference => {:these => 'params'}
        assigns[:pppams_reference].should equal(mock_pppams_reference)
      end

      it "redirects to the created pppams_reference" do
        PppamsReference.stub!(:new).and_return(mock_pppams_reference(:save => true))
        post :create, :pppams_reference => {}
        response.should redirect_to(pppams_reference_url(mock_pppams_reference))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved pppams_reference as @pppams_reference" do
        PppamsReference.stub!(:new).with({'these' => 'params'}).and_return(mock_pppams_reference(:save => false))
        post :create, :pppams_reference => {:these => 'params'}
        assigns[:pppams_reference].should equal(mock_pppams_reference)
      end

      it "re-renders the 'new' template" do
        PppamsReference.stub!(:new).and_return(mock_pppams_reference(:save => false))
        post :create, :pppams_reference => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested pppams_reference" do
        PppamsReference.should_receive(:find).with("37").and_return(mock_pppams_reference)
        mock_pppams_reference.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :pppams_reference => {:these => 'params'}
      end

      it "assigns the requested pppams_reference as @pppams_reference" do
        PppamsReference.stub!(:find).and_return(mock_pppams_reference(:update_attributes => true))
        put :update, :id => "1"
        assigns[:pppams_reference].should equal(mock_pppams_reference)
      end

      it "redirects to the pppams_reference" do
        PppamsReference.stub!(:find).and_return(mock_pppams_reference(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(pppams_reference_url(mock_pppams_reference))
      end
    end

    describe "with invalid params" do
      it "updates the requested pppams_reference" do
        PppamsReference.should_receive(:find).with("37").and_return(mock_pppams_reference)
        mock_pppams_reference.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :pppams_reference => {:these => 'params'}
      end

      it "assigns the pppams_reference as @pppams_reference" do
        PppamsReference.stub!(:find).and_return(mock_pppams_reference(:update_attributes => false))
        put :update, :id => "1"
        assigns[:pppams_reference].should equal(mock_pppams_reference)
      end

      it "re-renders the 'edit' template" do
        PppamsReference.stub!(:find).and_return(mock_pppams_reference(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested pppams_reference" do
      PppamsReference.should_receive(:find).with("37").and_return(mock_pppams_reference)
      mock_pppams_reference.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the pppams_reference list" do
      PppamsReference.stub!(:find).and_return(mock_pppams_reference(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(pppams_references_url)
    end
  end

end
