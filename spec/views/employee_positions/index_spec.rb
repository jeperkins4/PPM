require File.dirname(__FILE__) + '/../../spec_helper'

describe 'employee_positions/index.rhtml' do
  before do
    @e = EmployeePosition.make
    assigns[:facility] = @e.position_number.position.position_type.facility
  end
  it 'should show pagination links' do
    assigns[:employee_positions] = EmployeePosition.paginate :per_page => 10, :page => 1
    render 'employee_positions/index'
    response.should have_tag("td", @e.position_number.position.title)
    response.should_not have_tag("a", '3')
    
  end
  
end
