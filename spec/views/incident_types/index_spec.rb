require File.dirname(__FILE__) + '/../../spec_helper'
describe 'incident_types/index.rhtml' do
  before do
    @e = IncidentType.make
  end
  it 'should show pagination links' do
    assigns[:incident_types] = IncidentType.paginate :per_page => 10, :page => 1
    render 'incident_types/index'
    response.should have_tag("td", @e.incident_type)
  end
  
end
