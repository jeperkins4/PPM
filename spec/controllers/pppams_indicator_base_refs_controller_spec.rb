require 'spec_helper'

describe PppamsIndicatorBaseRefsController do
  before do
    login_as_admin
  end

  def mock_pppams_indicator_base_ref(stubs={})
    @mock_pppams_indicator_base_ref ||= mock_model(PppamsIndicatorBaseRef, stubs)
  end

  describe "GET index" do
    it "assigns all pppams_indicator_base_refs as @pppams_indicator_base_refs" do
      PppamsIndicatorBaseRef.stub!(:paginate).and_return([mock_pppams_indicator_base_ref])
      get :index
      assigns[:pppams_indicator_base_refs].should == [mock_pppams_indicator_base_ref]
    end
    it 'should be capable of filtering data by question content or category'
  end

  describe "GET show" do
    it "assigns the requested pppams_indicator_base_ref as @pppams_indicator_base_ref" do
      mock_pppams_indicator_base_ref(:current_facilities_hash => true)
      PppamsIndicatorBaseRef.stub!(:find).with("37").and_return(mock_pppams_indicator_base_ref)
      get :show, :id => "37"
      assigns[:pppams_indicator_base_ref].should equal(mock_pppams_indicator_base_ref)
    end
  end

  describe "GET new" do
    it "assigns a new pppams_indicator_base_ref as @pppams_indicator_base_ref" do
      PppamsIndicatorBaseRef.stub!(:new).and_return(mock_pppams_indicator_base_ref)
      get :new
      assigns[:pppams_indicator_base_ref].should equal(mock_pppams_indicator_base_ref)
    end
    it "assigns a pppams_category_base_refs for select as @pppams_category_base_refs" do
      PppamsIndicatorBaseRef.stub!(:new).and_return(mock_pppams_indicator_base_ref)
      @pppams_category_base_refs = [mock_model(PppamsCategoryBaseRef, :id => 1, :name => 'hello')]
      PppamsCategoryBaseRef.stub!(:all).and_return(@pppams_category_base_refs)
      get :new
      assigns[:pppams_category_base_refs].should == [['hello', 1]]
    end
  end

  describe "GET edit" do
    it "assigns the requested pppams_indicator_base_ref as @pppams_indicator_base_ref" do
      PppamsIndicatorBaseRef.stub!(:find).with("37").and_return(mock_pppams_indicator_base_ref)
      PppamsIndicatorBaseRef.stub!(:current_facilities_hash).with('37').and_return( {1 => {:active => true, :name => 'Graceville'}})
      get :edit, :id => "37"
      assigns[:pppams_indicator_base_ref].should equal(mock_pppams_indicator_base_ref)
    end
    it "assigns existing_facilities" do
      PppamsIndicatorBaseRef.stub!(:find).with("37").and_return(mock_pppams_indicator_base_ref)
      PppamsIndicatorBaseRef.stub!(:current_facilities_hash).with('37').and_return( {1 => {:active => true, :name => 'Graceville'}})
      get :edit, :id => '37'
      assigns[:facilities].should == {1 => {:active => true, :name => 'Graceville'}}
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created pppams_indicator_base_ref as @pppams_indicator_base_ref" do
        PppamsIndicatorBaseRef.stub!(:new).with({'these' => 'params'}).and_return(mock_pppams_indicator_base_ref(:save => true))
        post :create, :pppams_indicator_base_ref => {:these => 'params'}
        assigns[:pppams_indicator_base_ref].should equal(mock_pppams_indicator_base_ref)
      end

      it "redirects to the created pppams_indicator_base_ref" do
        PppamsIndicatorBaseRef.stub!(:new).and_return(mock_pppams_indicator_base_ref(:save => true))
        post :create, :pppams_indicator_base_ref => {}
        response.should redirect_to(pppams_indicator_base_ref_url(mock_pppams_indicator_base_ref))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved pppams_indicator_base_ref as @pppams_indicator_base_ref" do
        PppamsIndicatorBaseRef.stub!(:new).with({'these' => 'params'}).and_return(mock_pppams_indicator_base_ref(:save => false))
        post :create, :pppams_indicator_base_ref => {:these => 'params'}
        assigns[:pppams_indicator_base_ref].should equal(mock_pppams_indicator_base_ref)
      end

      it "re-renders the 'new' template" do
        PppamsIndicatorBaseRef.stub!(:new).and_return(mock_pppams_indicator_base_ref(:save => false))
        post :create, :pppams_indicator_base_ref => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested pppams_indicator_base_ref" do
        PppamsIndicatorBaseRef.should_receive(:find).with("37").and_return(mock_pppams_indicator_base_ref)
        mock_pppams_indicator_base_ref.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :pppams_indicator_base_ref => {:these => 'params'}
      end

      it "assigns the requested pppams_indicator_base_ref as @pppams_indicator_base_ref" do
        PppamsIndicatorBaseRef.stub!(:find).and_return(mock_pppams_indicator_base_ref(:update_attributes => true))
        put :update, :id => "1"
        assigns[:pppams_indicator_base_ref].should equal(mock_pppams_indicator_base_ref)
      end

      it "redirects to the pppams_indicator_base_ref edit path" do
        PppamsIndicatorBaseRef.stub!(:find).and_return(mock_pppams_indicator_base_ref(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(edit_pppams_indicator_base_ref_url(mock_pppams_indicator_base_ref))
      end

      it "should create new pppams_indicator if the 'active_on' date is set, and update existing indicators if the date isn't set" do
        attributes_hash =   {'pppams_indicators_attributes' => 
                              { '0' =>
                                {'id' => '',
                                 'facility_id' => '2',
                                 'active_on(1i)' => '2008',
                                 'active_on(2i)' => '3',
                                 'active_on(3i)' => '4'
                                }
                              }
                            }
        mock_indicator = mock_model(PppamsIndicator)
        PppamsIndicatorBaseRef.should_receive(:find).with('2').and_return(mock_indicator)
        mock_indicator.should_receive(:update_attributes).with(attributes_hash).and_return(true)

        put :update, :id => '2', :pppams_indicator_base_ref => attributes_hash
      end
    end

    describe "with invalid params" do
      it "updates the requested pppams_indicator_base_ref" do
        PppamsIndicatorBaseRef.should_receive(:find).with("37").and_return(mock_pppams_indicator_base_ref)
        mock_pppams_indicator_base_ref.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :pppams_indicator_base_ref => {:these => 'params'}
      end

      it "assigns the pppams_indicator_base_ref as @pppams_indicator_base_ref" do
        PppamsIndicatorBaseRef.stub!(:find).and_return(mock_pppams_indicator_base_ref(:update_attributes => false))
        put :update, :id => "1"
        assigns[:pppams_indicator_base_ref].should equal(mock_pppams_indicator_base_ref)
      end

      it "redirects to the 'edit' action" do
        PppamsIndicatorBaseRef.stub!(:find).and_return(mock_pppams_indicator_base_ref(:update_attributes => false))
        put :update, :id => "1"
        response.should redirect_to(edit_pppams_indicator_base_ref_path(1))
      end
    end

  end

end
