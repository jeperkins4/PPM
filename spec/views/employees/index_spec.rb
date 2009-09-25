require File.dirname(__FILE__) + '/../../spec_helper'
describe 'employees/index.rhtml' do
  before do
    @e = Employee.make
    assigns[:facility] = @e.facility
  end
  it 'should show pagination links' do
    assigns[:employees] = Employee.paginate :per_page => 10, :page => 1
    render 'employees/index'
    response.should have_tag("td", @e.first_name)
  end
  
end
