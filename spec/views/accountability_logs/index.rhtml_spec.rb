 require File.dirname(__FILE__) + '/../../spec_helper'

 describe "accountability_logs/index.rhtml" do
   before do
     session[:user_id] = User.make.id
     session[:facility] = Facility.make
     27.times do |i|
       c = Context.make(:position => i)
       (3..5).to_a.rand.times {|i| Prompt.make(:context_id => c.id)}
       AccountabilityLogs.make(:facility => session[:facility],
                               :context_id => c.id)
     end
     assigns[:categories] = Context.paginate(:all, :order => 'position', :per_page => 1, :page => 1)
   end
   it 'should show a list of links for months' do
     render 'accountability_logs/index'
     response.should have_tag("h2", "Accountability Log")
   end
   it 'should show a list of links for categories'do
     render 'accountability_logs/index'
     response.should have_tag("a[href=/accountability_logs?category=2]", "2")
   end
 end
