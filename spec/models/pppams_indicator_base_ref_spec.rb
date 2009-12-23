require 'spec_helper'

describe PppamsIndicatorBaseRef do
  before(:each) do
    @valid_attributes = {
      :question => "value for question",
      :pppams_category_base_ref_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    PppamsIndicatorBaseRef.create!(@valid_attributes)
  end
end
