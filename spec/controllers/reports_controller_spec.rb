require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe ReportsController do
  integrate_views 
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
        incident = Incident.make(:description => 'hello descript')
        session[:facility] = incident.facility
        post :index, :report => {:report_type => 'incident', 
                                 :use_date => 'No',
                                 :status => 'All',
                                 :category => PppamsIssue.categories[0],
                                 :ready => '1'
                      }
        session[:report].should have(1).record
        response.should be_redirect
      end
      it 'should render non_comp reports' do
        non_comp_issue = NonCompIssue.make
        session[:facility] = non_comp_issue.facility
        post :index, :report => {:report_type => 'non_comp_issue', 
                                :use_date => 'No',
                                :status => 'All',
                                :category => PppamsIssue.categories[0],
                                :ready => '1'
                      }
        session[:report].should have(1).record
        response.should be_redirect
      end
    end
  end
end
