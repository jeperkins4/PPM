require File.dirname(__FILE__) + '/../spec_helper'

def retrieve_pristine_record(options = {})
  PppamsIndicator.active_in_months( Date.new(2009,3,1), 
                                    Date.new(2009,4,1),
                                    {:facility_ids => [@pppams_indicator.facility_id]}.merge(options)
                                  )
end

describe PppamsIndicator do
  before(:all) do
    @pppams_indicator = PppamsIndicator.make(:start_month => Date.today.month,
                                            :active_on => Date.yesterday,
                                            :inactive_on => Date.tomorrow)
  end
  specify { @pppams_indicator.should respond_to(:pppams_indicator_base_ref) }
  describe "find_current_to_do" do
    before(:all) do
      @facility = @pppams_indicator.facility
      @current_review = PppamsReview.make(:pppams_indicator => @pppams_indicator,
                                          :created_on => Time.now)
      @old_review= PppamsReview.make(:pppams_indicator => @pppams_indicator,
                                          :created_on => 2.months.ago)
      @next_month_review= PppamsReview.make(:pppams_indicator => @pppams_indicator,
                                          :created_on => 2.months.since)
    end

    it "should find review created during given date's month" do
      @current_review.update_attribute(:status, 'Locked')
      PppamsIndicator.should_receive(:find_current).with(Date.today, @facility).and_return([stub(:id => @pppams_indicator.id),
                                                                                            stub(:id => 0)])
      second_indicator = PppamsIndicator.make(:facility => @facility,
                           :active_on => Date.yesterday,
                           :inactive_on => Date.tomorrow,
                           :start_month => Date.today.month)
      PppamsReview.make(:pppams_indicator => second_indicator,
                        :status => '')
      PppamsIndicator.find_current_todo(Date.today, @facility).should == [1,2]
    end
  end

  describe "current_review for an indicator" do
    before(:all) do
      @facility = @pppams_indicator.facility
      @current_review = PppamsReview.make(:pppams_indicator => @pppams_indicator,
                                          :created_on => Time.now)
      @old_review= PppamsReview.make(:pppams_indicator => @pppams_indicator,
                                          :created_on => 2.months.ago)
      @next_month_review= PppamsReview.make(:pppams_indicator => @pppams_indicator,
                                          :created_on => 2.months.since)
    end

    it "should find review created during given date's month" do
      @pppams_indicator.current_review(Time.now).should == @current_review
    end
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
    it "should set the months requiring indication according to the frequency and start month." do
      @pppams_indicator.good_months= nil
      @pppams_indicator.good_months.should == nil
      @pppams_indicator.frequency = 3
      @pppams_indicator.start_month = 8
      @pppams_indicator.set_good_months
      @pppams_indicator.good_months.should == ":8:12:4:"
    end
  end
  describe "update_good_months" do
    it "should set the months requiring indication according to the frequency and start month." do
      @pppams_indicator.good_months= nil
      @pppams_indicator.save
      @pppams_indicator.good_months.should == nil
      @pppams_indicator.update_good_months(3,6)
      @pppams_indicator.good_months.should == ":3:5:7:9:11:1:"
    end
  end

  describe "active_in_months should retrieve" do
    before(:all) do
      PppamsIndicator.destroy_all
      @pppams_indicator = PppamsIndicator.make(:start_month => 1,
                                               :active_on => Date.new(2009,1,1),
                                               :inactive_on => nil,
                                               :good_months => ":3:")
    end

    it "indicators that are active before or on the start date" do
      PppamsIndicator.make(:facility => @pppams_indicator.facility,
                           :start_month => 1,
                           :active_on => Date.new(2009,3,2),
                           :inactive_on => nil,
                           :good_months => ":3:")
      results = retrieve_pristine_record
      results.should have(1).record
    end

    it "indicators whose inactive date is after or on the end date or whose inactive date is nil" do
      PppamsIndicator.make(:facility => @pppams_indicator.facility,
                           :start_month => 1,
                           :active_on => Date.new(2009,1,1),
                           :inactive_on => Date.new(2009,3,3),
                           :good_months => ":3:")
      results = retrieve_pristine_record
      results.should have(1).record
    end

    it "indicators for all facilities if no facility was given" do
      PppamsIndicator.make(:start_month => 1,
                           :active_on => Date.new(2009,1,1),
                           :inactive_on => nil,
                           :good_months => ":3:")
      results = PppamsIndicator.active_in_months( Date.new(2009,3,1), Date.new(2009,4,1))
      results.should have(2).record
    end


    it "indicators whose good months are between the start and end dates" do
      PppamsIndicator.make(:facility => @pppams_indicator.facility,
                           :start_month => 1,
                           :active_on => Date.new(2009,1,1),
                           :inactive_on => nil,
                           :good_months => ":6:")
      results = retrieve_pristine_record
      results.should have(1).record
    end

    it "indicators whose indicator_base_ref_ids match the given criteria" do
      PppamsIndicator.make(:facility => @pppams_indicator.facility,
                           :start_month => 1,
                           :active_on => Date.new(2009,1,1),
                           :inactive_on => nil,
                           :good_months => ":3:")
      results = retrieve_pristine_record({:pppams_indicator_base_ref_ids => @pppams_indicator.pppams_indicator_base_ref_id})
      results.should have(1).record
    end

    it "indicators whose category_base_ref_ids match the given criteria" do
      indicator_base_with_other_category = PppamsIndicatorBaseRef.make
      PppamsIndicator.make(:facility => @pppams_indicator.facility,
                           :start_month => 1,
                           :active_on => Date.new(2009,1,1),
                           :inactive_on => nil,
                           :good_months => ":3:",
                           :pppams_indicator_base_ref => indicator_base_with_other_category)
      results = retrieve_pristine_record({:pppams_category_base_ref_ids => @pppams_indicator.pppams_indicator_base_ref.pppams_category_base_ref_id})
      results.should have(1).record
    end

    it "an indicator's id" do
      retrieve_pristine_record[0].id.should == @pppams_indicator.id
    end

    it "an indicator's base reference id" do
      retrieve_pristine_record[0].pppams_indicator_base_ref_id.should == @pppams_indicator.pppams_indicator_base_ref_id
    end

    it "an indicator's category id" do
      retrieve_pristine_record[0].pppams_category_base_ref_id.should == @pppams_indicator.pppams_category_base_ref.id
    end

    it "the good_months attribute" do
      retrieve_pristine_record[0].good_months.should == @pppams_indicator.good_months
    end
    it "the facility_id attribute" do
      retrieve_pristine_record[0].facility_id.should == @pppams_indicator.facility_id
    end
    it "the facility_name attribute" do
      retrieve_pristine_record[0].facility_name.should == @pppams_indicator.facility.facility
    end
    it "the indicator_name attribute" do
      retrieve_pristine_record[0].indicator_name.should == @pppams_indicator.pppams_indicator_base_ref.question
    end
    it "the category_name attribute" do
      retrieve_pristine_record[0].category_name.should == @pppams_indicator.pppams_indicator_base_ref.pppams_category_base_ref.name
    end
  end

end
