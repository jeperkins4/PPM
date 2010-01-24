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


  describe "review scores by category" do
    before(:all) do
      @category_1 = PppamsCategoryBaseRef.make
      @indicator_base_ref_1 = PppamsIndicatorBaseRef.make(:pppams_category_base_ref => @category_1)
      @indicator_1 = PppamsIndicator.make(:pppams_indicator_base_ref => @indicator_base_ref_1,
                                          :good_months => ':1:')
      @review_cat_1 = PppamsReview.make(:pppams_indicator => @indicator_1)

      @category_2 = PppamsCategoryBaseRef.make
      @indicator_base_ref_2 = PppamsIndicatorBaseRef.make(:pppams_category_base_ref => @category_2)
      @indicator_2 = PppamsIndicator.make(:pppams_indicator_base_ref => @indicator_base_ref_2,
                                          :good_months => ':1:2:')
      @review_2 = PppamsReview.make(:pppams_indicator => @indicator_2)

      @indicator_base_ref_3 = PppamsIndicatorBaseRef.make(:pppams_category_base_ref => @category_2)
      @indicator_3_cat_2 = PppamsIndicator.make(:pppams_indicator_base_ref => @indicator_base_ref_3,
                                         :good_months => ':3:4:')
      @review_3_cat_2= PppamsReview.make(:pppams_indicator => @indicator_3_cat_2)
      @indicator_array = [@indicator_1, @indicator_2, @indicator_3_cat_2]
    end
    describe "category_max_review_sums should" do
      it "return all category ids of given indicators" do
        results = PppamsCategoryBaseRef.category_max_review_sums(@indicator_array, [])
        results.keys.should include(@category_1.id, @category_2.id)
      end

      it "return the max sum of all review scores for a particular category" do
        results = PppamsCategoryBaseRef.category_max_review_sums(@indicator_array, [1,2])
        results[@category_2.id][:max_score].should == 20
        results[@category_1.id][:max_score].should == 10
      end

      it "return the max number of reviews for a particular category" do
        results = PppamsCategoryBaseRef.category_max_review_sums(@indicator_array, [1,2])
        results[@category_2.id][:max_reviews].should == 2
        results[@category_1.id][:max_reviews].should == 1
      end
    end
    describe "category_actual_review_sums" do
      before :each do
        @review_1 = mock_model(PppamsReview, :pppams_category_base_ref_id => 1,
                                             :score => 7)
        @review_2 = mock_model(PppamsReview, :pppams_category_base_ref_id => 2,
                                             :score => 5)
        @review_3 = mock_model(PppamsReview, :pppams_category_base_ref_id => 2,
                                             :score => 7)
        @reviews = [@review_1, @review_2, @review_3]

      end
      it "sums category review scores for given categories" do
        results = PppamsCategoryBaseRef.category_actual_review_sums(@reviews)
        results[@review_1.pppams_category_base_ref_id][:actual_score].should == 7
        results[@review_2.pppams_category_base_ref_id][:actual_score].should == 12
      end
      it "sums number of reviews for given categories" do
        results = PppamsCategoryBaseRef.category_actual_review_sums(@reviews)
        results[@review_1.pppams_category_base_ref_id][:actual_reviews].should == 1
        results[@review_2.pppams_category_base_ref_id][:actual_reviews].should == 2
      end
    end
  end
  describe "summary_for_facility_between" do
     before(:all) do
      [PppamsReview, PppamsIndicator, PppamsIndicatorBaseRef, PppamsCategoryBaseRef, PppamsCategoryGroup].each do |f|
        f.send(:destroy_all)
      end
      @category_1 = PppamsCategoryBaseRef.make
      @indicator_base_ref_1 = PppamsIndicatorBaseRef.make(:pppams_category_base_ref => @category_1)
      @indicator_1 = PppamsIndicator.make(:pppams_indicator_base_ref => @indicator_base_ref_1,
                                          :good_months => ':1:',
                                          :active_on => Date.new(2009,1,1),
                                          :inactive_on => nil)
      @review_cat_1 = PppamsReview.make(:pppams_indicator => @indicator_1,
                                        :created_on => Date.new(2009,1,1),
                                        :status => 'Locked',
                                        :score => 5)

      @category_2 = PppamsCategoryBaseRef.make(:pppams_category_group => @category_1.pppams_category_group)
      @indicator_base_ref_2 = PppamsIndicatorBaseRef.make(:pppams_category_base_ref => @category_2)
      @indicator_2 = PppamsIndicator.make(:pppams_indicator_base_ref => @indicator_base_ref_2,
                                          :good_months => ':1:2:',
                                          :facility => @indicator_1.facility,
                                          :active_on => Date.new(2009,1,1),
                                          :inactive_on => nil)
      @review_2 = PppamsReview.make(:pppams_indicator => @indicator_2,
                                          :created_on => Date.new(2009,1,1),
                                          :status => 'Locked',
                                          :score => 6)

      @indicator_base_ref_3 = PppamsIndicatorBaseRef.make(:pppams_category_base_ref => @category_2)
      @indicator_3_cat_2 = PppamsIndicator.make(:pppams_indicator_base_ref => @indicator_base_ref_3,
                                          :good_months => ':3:4:',
                                          :facility => @indicator_1.facility,
                                          :active_on => Date.new(2009,1,1),
                                          :inactive_on => nil)
      @review_3_cat_2= PppamsReview.make(:pppams_indicator => @indicator_3_cat_2,
                                         :created_on => Date.new(2009,1,1),
                                        :status => 'Locked')
    end
    it 'should narrow search by facility' do
      PppamsIndicator.should_receive(:active_in_months).with(1, Date.today, Date.tomorrow).and_return([])
      PppamsCategoryBaseRef.summary_for_facility_between(1, Date.today, Date.tomorrow)
    end
    it 'should return a list of maximum reviews per category group' do
      results = PppamsCategoryBaseRef.summary_for_facility_between(@indicator_1.facility_id,
                                                         Date.new(2009,1,1),
                                                         Date.new(2009,1,1))
      results.should == {@category_1.pppams_category_group_id => {
                                                                  :name => @category_1.pppams_category_group.name,
                                                                  :max_score => 20,
                                                                  :actual_score => 11,
                                                                  :percent => 55.0,
                                                                  :categories => [
                                                                                   {
                                                                                     :name => @category_1.name,
                                                                                     :max_score => 10,
                                                                                     :actual_score => 5,
                                                                                     :percent => 50.0,
                                                                                     :missing_reviews => false
                                                                                   },
                                                                                   {
                                                                                     :name => @category_2.name,
                                                                                     :max_score => 10,
                                                                                     :actual_score => 6,
                                                                                     :percent => 60.0,
                                                                                     :missing_reviews => false
                                                                                   }

                                                                                 ]
                                                                 },
                      :actual_score => 11,
                      :max_score => 20,
                      :percent => 55.0
                     }
    end
#    it "should ignore indicator groups that do not have reviews" do
#      @indicator_4 = PppamsIndicator.make(:facility => @indicator_1.facility,
#                                          :good_months => ':3:4:',
#                                          :active_on => Date.new(2009,1,1),
#                                          :inactive_on => nil,
#                                          :pppams_indicator_base_ref => @indicator_base_ref_1
#
#    end
  end
end
