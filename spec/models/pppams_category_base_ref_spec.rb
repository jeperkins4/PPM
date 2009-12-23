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
end
