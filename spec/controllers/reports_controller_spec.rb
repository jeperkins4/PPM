require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe ReportsController do
  
  before do
    @admin = User.make(:administrator)
    login_as @admin
  end
  
  describe 'GET' do
    describe 'index' do
      it 'should render a reports selection page' do
        session[:facility] = Facility.make 
        get :index
        response.should be_success
      end
    end
  end
  
  describe 'POST' do
    # The reports has MANY javascript bugs. We should put this on the radar
    # for future releases. I submitted the ticket #154 into software.myflorida.com about this.
    describe 'index' do
      
      it 'should render incident reports' do
        incident = Incident.make
        session[:facility] = incident.facility
        session[:type] = 'Incident'
        session[:use_date] = 'No'
        session[:status] = 'All'
        session[:category] = PppamsIssue.categories[0]
        session[:report] = {}
        session[:report][:ready] = '1'
        post :index
        response.should be_success
        response.should have_text incident.description
      end
      it 'should render non_comp reports' do
        incident = Incident.make
        session[:facility] = incident.facility
        session[:type] = 'Non Comp Issue'
        session[:use_date] = 'No'
        session[:status] = 'All'
        session[:category] = PppamsIssue.categories[0]
        session[:report] = {}
        session[:report][:ready] = '1'
        post :index
        response.should be_success
        response.should have_text incident.description
      end
    end
  end
end