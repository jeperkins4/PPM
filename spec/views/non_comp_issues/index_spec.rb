require File.dirname(__FILE__) + '/../../spec_helper'

describe 'non_comp_issues/index.rhtml' do
  before do
    f = Facility.make
    assigns[:facility] = f
    27.times {|i| NonCompIssue.make(:facility => f)}
  end
  it 'should show pagination links' do
    assigns[:non_comp_issues] = NonCompIssue.paginate :per_page => 20, :page => 1
    render 'non_comp_issues/index'
    response.should have_tag("a[rel=next]", '2')
    response.should_not have_tag("a", '3')
    
  end
  
end
