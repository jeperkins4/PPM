require 'spec_helper'

describe PppamsCategoryBaseRefsController do

  def mock_pppams_category_base_ref(stubs={})
    @mock_pppams_category_base_ref ||= mock_model(PppamsCategoryBaseRef, stubs)
  end

  describe "GET index" do
    it "assigns all pppams_category_base_refs as @pppams_category_base_refs" do
      PppamsCategoryBaseRef.stub!(:find).with(:all).and_return([mock_pppams_category_base_ref])
      get :index
      assigns[:pppams_category_base_refs].should == [mock_pppams_category_base_ref]
    end
  end

  describe "GET show" do
    it "assigns the requested pppams_category_base_ref as @pppams_category_base_ref" do
      PppamsCategoryBaseRef.stub!(:find).with("37").and_return(mock_pppams_category_base_ref)
      get :show, :id => "37"
      assigns[:pppams_category_base_ref].should equal(mock_pppams_category_base_ref)
    end
  end

  describe "GET new" do
    it "assigns a new pppams_category_base_ref as @pppams_category_base_ref" do
      PppamsCategoryBaseRef.stub!(:new).and_return(mock_pppams_category_base_ref)
      get :new
      assigns[:pppams_category_base_ref].should equal(mock_pppams_category_base_ref)
    end
  end

  describe "GET edit" do
    it "assigns the requested pppams_category_base_ref as @pppams_category_base_ref" do
      PppamsCategoryBaseRef.stub!(:find).with("37").and_return(mock_pppams_category_base_ref)
      get :edit, :id => "37"
      assigns[:pppams_category_base_ref].should equal(mock_pppams_category_base_ref)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created pppams_category_base_ref as @pppams_category_base_ref" do
        PppamsCategoryBaseRef.stub!(:new).with({'these' => 'params'}).and_return(mock_pppams_category_base_ref(:save => true))
        post :create, :pppams_category_base_ref => {:these => 'params'}
        assigns[:pppams_category_base_ref].should equal(mock_pppams_category_base_ref)
      end

      it "redirects to the created pppams_category_base_ref" do
        PppamsCategoryBaseRef.stub!(:new).and_return(mock_pppams_category_base_ref(:save => true))
        post :create, :pppams_category_base_ref => {}
        response.should redirect_to(pppams_category_base_ref_url(mock_pppams_category_base_ref))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved pppams_category_base_ref as @pppams_category_base_ref" do
        PppamsCategoryBaseRef.stub!(:new).with({'these' => 'params'}).and_return(mock_pppams_category_base_ref(:save => false))
        post :create, :pppams_category_base_ref => {:these => 'params'}
        assigns[:pppams_category_base_ref].should equal(mock_pppams_category_base_ref)
      end

      it "re-renders the 'new' template" do
        PppamsCategoryBaseRef.stub!(:new).and_return(mock_pppams_category_base_ref(:save => false))
        post :create, :pppams_category_base_ref => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested pppams_category_base_ref" do
        PppamsCategoryBaseRef.should_receive(:find).with("37").and_return(mock_pppams_category_base_ref)
        mock_pppams_category_base_ref.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :pppams_category_base_ref => {:these => 'params'}
      end

      it "assigns the requested pppams_category_base_ref as @pppams_category_base_ref" do
        PppamsCategoryBaseRef.stub!(:find).and_return(mock_pppams_category_base_ref(:update_attributes => true))
        put :update, :id => "1"
        assigns[:pppams_category_base_ref].should equal(mock_pppams_category_base_ref)
      end

      it "redirects to the pppams_category_base_ref" do
        PppamsCategoryBaseRef.stub!(:find).and_return(mock_pppams_category_base_ref(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(pppams_category_base_ref_url(mock_pppams_category_base_ref))
      end
    end

    describe "with invalid params" do
      it "updates the requested pppams_category_base_ref" do
        PppamsCategoryBaseRef.should_receive(:find).with("37").and_return(mock_pppams_category_base_ref)
        mock_pppams_category_base_ref.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :pppams_category_base_ref => {:these => 'params'}
      end

      it "assigns the pppams_category_base_ref as @pppams_category_base_ref" do
        PppamsCategoryBaseRef.stub!(:find).and_return(mock_pppams_category_base_ref(:update_attributes => false))
        put :update, :id => "1"
        assigns[:pppams_category_base_ref].should equal(mock_pppams_category_base_ref)
      end

      it "re-renders the 'edit' template" do
        PppamsCategoryBaseRef.stub!(:find).and_return(mock_pppams_category_base_ref(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested pppams_category_base_ref" do
      PppamsCategoryBaseRef.should_receive(:find).with("37").and_return(mock_pppams_category_base_ref)
      mock_pppams_category_base_ref.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the pppams_category_base_refs list" do
      PppamsCategoryBaseRef.stub!(:find).and_return(mock_pppams_category_base_ref(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(pppams_category_base_refs_url)
    end
  end

end
