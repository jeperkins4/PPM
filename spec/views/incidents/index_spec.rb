require File.dirname(__FILE__) + '/../../spec_helper'

describe 'incidents/index.rhtml' do
  before do
    f = Facility.make
    assigns[:facility] = f
    27.times {|i| Incident.make(:facility => f)}
  end
  it 'should show pagination links' do
    assigns[:incidents] = Incident.paginate :per_page => 20, :page => 1
    render 'incidents/index'
    response.should have_tag("a[rel=next]", '2')
    response.should_not have_tag("a", '3')
    
  end
  
end
