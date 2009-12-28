require 'spec_helper'

describe PppamsCategoryBaseRef do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :pppams_category_group_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    PppamsCategoryBaseRef.create!(@valid_attributes)
  end
  it 'should print out the name attribute for string values' do
    pppams_category_base_ref = PppamsCategoryBaseRef.create!(@valid_attributes)
    pppams_category_base_ref.to_s.should == 'value for name'
  end

end
