require 'spec_helper'

describe "/pppams_references/index.rhtml" do

  before(:each) do
    assigns[:user].should_receive('is_admin?').at_least(1).and_return(true)
    assigns[:pppams_references] =WillPaginate::Collection.new(1,10).replace([
      stub_model(PppamsReference,
        :name => "value for name",
        :url => "value for url",
        :id => 1
      ),
      stub_model(PppamsReference,
        :name => "value for name",
        :url => "value for url",
        :id => 2
      )
    ])

  end

  it "renders a list of pppams_references" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for url".to_s, 2)
  end
end
