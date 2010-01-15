require File.dirname(__FILE__) + '/../spec_helper'

describe PppamsIndicator do
  before(:all) do
    @pppams_indicator = PppamsIndicator.make
  end
  specify { @pppams_indicator.should respond_to(:pppams_indicator_base_ref) }
  describe "find_current_to_do" do
    it "should handle the new indicator/category relations"
  end
  describe "current_review" do
    it "should handle the new indicator/category relations"
  end
  describe "" do
    it "should handle the new indicator/category relations"
  end
  describe "find_current (DIFFERENT FROM find_current_to_do)" do
    before :all do
      PppamsIndicator.destroy_all
      Facility.destroy_all
      PppamsIndicatorBaseRef.destroy_all
      PppamsCategoryBaseRef.destroy_all

      @different_facility = Facility.make(:pppams_started_on => Date.yesterday)
      @different_fac_indicator = PppamsIndicator.make(:facility => @different_facility,
                     :active_on => Date.yesterday,
                     :inactive_on => Date.tomorrow,
                     :good_months => ":#{Date.today.month}:")
      base_cat_a = PppamsCategoryBaseRef.make(:name => 'a')
      base_ind_a = PppamsIndicatorBaseRef.make(:pppams_category_base_ref => base_cat_a)
      base_cat_b = PppamsCategoryBaseRef.make(:name => 'b')
      base_ind_b = PppamsIndicatorBaseRef.make(:pppams_category_base_ref => base_cat_b)

      @facility = Facility.make(:pppams_started_on => Date.yesterday)
      @indicator = PppamsIndicator.make(:facility => @facility,
                                        :pppams_indicator_base_ref => base_ind_a,
                                        :active_on => Date.yesterday,
                                        :inactive_on => Date.tomorrow,
                                        :good_months => ":#{Date.today.month}:")
      @indicator_category_z = PppamsIndicator.make(:facility => @facility,
                                                   :pppams_indicator_base_ref => base_ind_b,
                                                   :active_on => Date.yesterday,
                                                   :inactive_on => Date.tomorrow,
                                                   :good_months => ":#{Date.today.month}:")
    end
    it "should include active indicators for given facility" do
      PppamsIndicator.find_current(Date.today, @facility).should include(@indicator, @indicator_category_z)
    end
    it 'should exclude indicators for another facility' do
      PppamsIndicator.find_current(Date.today, @facility).should_not include(@different_fac_indicator)
    end
    it "should include indicators if their inactive_on is null" do
      [@indicator, @indicator_category_z].each {|i| i.update_attribute(:inactive_on, nil) }
      PppamsIndicator.find_current(Date.today, @facility).should include(@indicator, @indicator_category_z)
      [@indicator, @indicator_category_z].each {|i| i.update_attribute(:inactive_on, Date.tomorrow) }
    end
    it "should exclude indicators if facility has not started recording pppams" do
      @facility.update_attribute(:pppams_started_on, Date.tomorrow)
      PppamsIndicator.find_current(Date.today, @facility).should be_empty
      @facility.update_attribute(:pppams_started_on, Date.yesterday)
    end
    it "should exclude indicators if active_on is after given date" do
      [@indicator, @indicator_category_z].each {|i| i.update_attribute(:active_on, Date.tomorrow) }
      PppamsIndicator.find_current(Date.today, @facility).should be_empty
      [@indicator, @indicator_category_z].each {|i| i.update_attribute(:active_on, Date.yesterday) }
    end
    it "should exclude indicators if inactive_on is before given date" do
      [@indicator, @indicator_category_z].each {|i| i.update_attribute(:inactive_on, Date.yesterday) }
      PppamsIndicator.find_current(Date.today, @facility).should be_empty
      [@indicator, @indicator_category_z].each {|i| i.update_attribute(:inactive_on, Date.tomorrow) }
    end
    it "should exclude indicators if their good_months does not have given month" do
      [@indicator, @indicator_category_z].each {|i| i.update_attribute(:good_months, ":#{Date.today.month - 1}:") }
      PppamsIndicator.find_current(Date.today, @facility).should be_empty
      [@indicator, @indicator_category_z].each {|i| i.update_attribute(:good_months, ":#{Date.today.month}:") }
    end
    it "should order indicators by category name" do
      PppamsIndicator.find_current(Date.today, @facility).should == [@indicator, @indicator_category_z]
    end
  end
  describe "set_good_months" do
    it "should handle the new indicator/category relations"
  end
end
