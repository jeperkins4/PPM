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
  describe "current_facilities" do
    before(:all) do
      Facility.all.each { |facility| facility.destroy }
      @base_indicator = PppamsIndicatorBaseRef.make
      @indicator_active = PppamsIndicator.make(:pppams_indicator_base_ref => @base_indicator, :active_on => Date.yesterday).facility
      @indicator_inactive = PppamsIndicator.make(:pppams_indicator_base_ref => @base_indicator, 
                                                 :inactive_on => Date.yesterday).facility
      @indicator_inactive_until_tomorrow = PppamsIndicator.make(:pppams_indicator_base_ref => @base_indicator, 
                                                 :active_on => Date.tomorrow).facility

      @facility_inactive = Facility.make
    end
    it "should retrieve all facilities regardless of active status" do
      PppamsIndicatorBaseRef.current_facilities.size.should == 4
    end
    describe "the hash version" do
      it "should say that a facility whose current indicator has inactive_on set is ':active => false'" do
        PppamsIndicatorBaseRef.current_facilities_hash(@base_indicator.id)[@indicator_inactive.id][:active].should == false
      end
      it "should say that a facility whose current indicator has inactive_on BLANK is ':active => true'" do
        PppamsIndicatorBaseRef.current_facilities_hash(@base_indicator.id)[@indicator_active.id][:active].should == true
      end
      it "should say that a facility without the specified indicator base is ':active => false'" do
        PppamsIndicatorBaseRef.current_facilities_hash(@base_indicator.id)[@facility_inactive.id][:active].should == false
      end
      it "should say that a facility an active date of tomorrow is inactive ':active => false'" do
        PppamsIndicatorBaseRef.current_facilities_hash(@base_indicator.id)[@indicator_inactive_until_tomorrow.id][:active].should == false
      end
    end
  end
end
