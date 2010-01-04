require File.dirname(__FILE__) + '/../spec_helper'

describe AccountabilityLogsController do
  before do
    login_as_admin
    session[:facility] = Facility.make
    27.times do |i|
      @c = Context.make(:position => i)
      (3..5).to_a.rand.times {|i| Prompt.make(:context_id => @c.id)}
      AccountabilityLogs.make(:facility => session[:facility],
                              :context_id => @c.id)
    end
   end
  describe 'GET index' do
    it 'should assign categories' do
     get :index
      assigns[:categories].should have(1).record
      assigns[:categories].total_entries.should == 27
    end
    it 'should paginate by one' do
      get :index, :category => 2
      assigns[:categories].should have(1).record
      assigns[:categories][0].position.should == 1
    end
    it 'should assign the current fiscal year to the session by default' do
      get :index
      if Time.now.month >= 7
        session[:admin_year].should == Time.now.year
      else
        session[:admin_year].should == Time.now.year - 1
      end
    end

  end
  describe "POST index" do
    it 'should tell me I updated stuff' do
      ps = {:page => 1,
       :month => 9,
       :questions => @c.prompts.inject({}) {|questions, prompt| questions[prompt.id] = '1'; questions}
      }
      post :index, ps
      response.should redirect_to :action => 'collect'
    end
  end
end
