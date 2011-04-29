require File.dirname(__FILE__) + '/../../spec_helper'
describe 'employees/index.rhtml' do
  before do
    Employee.destroy_all
    @e = Employee.make
    assigns[:facility] = @e.facility
  end
  it 'should show pagination links' do
    assigns[:employees] = Employee.all.paginate :per_page => 10, :page => 1
    render 'employees/index'
    response.should have_tag("table#employees td", @e.first_name)
  end
end
