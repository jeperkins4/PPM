require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
describe PositionsController do

  integrate_views
  
  before do
    @admin = User.make(:administrator)
    login_as @admin
    @p = Position.make(:with_facility)
    session[:facility]= @p.position_type.facility
  end
  describe 'index' do
    it 'should display a list of positions for the selected facility' do
      get :index
      response.should be_success
      response.should have_tag('td', @p.title )
      response.should have_tag('td', @p.position_type.position_type )
      response.should have_tag('h1', /#{@p.position_type.facility.facility}/)
    end
  end
  
  describe 'show' do
    it 'should show you position details' do
      get :show, {:id => @p.id}
      response.should be_success
      response.should have_tag('p', /#{@p.title}/)
      response.should have_tag('p', /#{@p.position_type.position_type}/)
    end
  end
  describe 'edit' do
    it 'assigns the requested position as @position' do
      Position.should_receive(:find).with(@p.id.to_s).and_return(@p)
      get :edit, :id => @p.id
      assigns[:position].should eql @p
      response.should be_success
    end
  end
  describe "destroy" do
    it "should destroy the position and return you to the index" do
      Position.should_receive(:find).with(@p.id.to_s).and_return(@p)
      @p.should_receive(:destroy)
      delete :destroy,  :id => @p.id
      response.should redirect_to(:action => 'index') do
        response.should be_success
      end
    end
  end
  
  describe "update" do
    it "should update records" do
      Position.should_receive(:find).with(@p.id.to_s).and_return(@p)
      @p.should_receive(:update_attributes).with({'title' => 'A new admin'})
      put :update, :id => @p.id.to_s, :position => {'title' => 'A new admin'}
      response.should redirect_to(position_path(@p.id)) do
        response.should be_success
        response.should have_tag('p', /A new admin/)
      end
    end
  end
end