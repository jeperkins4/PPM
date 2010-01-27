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
                                          :start_month => 1,
                                          :frequency => 1 )
      @review_cat_1 = PppamsReview.make(:pppams_indicator => @indicator_1)

      @category_2 = PppamsCategoryBaseRef.make
      @indicator_base_ref_2 = PppamsIndicatorBaseRef.make(:pppams_category_base_ref => @category_2)
      @indicator_2 = PppamsIndicator.make(:pppams_indicator_base_ref => @indicator_base_ref_2,
                                          :start_month => 1,
                                          :frequency => 2 )
      @review_2 = PppamsReview.make(:pppams_indicator => @indicator_2)

      @indicator_base_ref_3 = PppamsIndicatorBaseRef.make(:pppams_category_base_ref => @category_2)
      @indicator_3_cat_2 = PppamsIndicator.make(:pppams_indicator_base_ref => @indicator_base_ref_3,
                                          :start_month => 3,
                                          :frequency => 2 )
      @review_3_cat_2= PppamsReview.make(:pppams_indicator => @indicator_3_cat_2)
      @indicator_array = [@indicator_1, @indicator_2, @indicator_3_cat_2]
    end
    describe "category_max_review_sums should" do
      it "return all category ids of given indicators" do
        results = PppamsCategoryBaseRef.category_max_review_sums(@indicator_array, [])
        results.keys.should include(@category_1.id, @category_2.id)
      end

      it "return the max sum of all review scores for a particular category" do
        results = PppamsCategoryBaseRef.category_max_review_sums(@indicator_array, [1,2,3,4,5,6])
        results[@category_2.id][:max_score].should == 20
        results[@category_1.id][:max_score].should == 10
      end

      it "return the max number of reviews for a particular category" do
        results = PppamsCategoryBaseRef.category_max_review_sums(@indicator_array, [1,2,3,4,5,6])
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
  describe "signature_summary_for_facility" do
     before(:all) do
      [PppamsReview, PppamsIndicator, PppamsIndicatorBaseRef, PppamsCategoryBaseRef, PppamsCategoryGroup].each do |f|
        f.send(:destroy_all)
      end
      @category_1 = PppamsCategoryBaseRef.make
      @indicator_base_ref_1 = PppamsIndicatorBaseRef.make(:pppams_category_base_ref => @category_1)
      @indicator_1 = PppamsIndicator.make(:pppams_indicator_base_ref => @indicator_base_ref_1,
                                          :start_month => 1,
                                          :frequency => 1,
                                          :active_on => Date.new(2009,1,1),
                                          :inactive_on => nil)
      @review_cat_1 = PppamsReview.make(:pppams_indicator => @indicator_1,
                                        :created_on => Date.new(2009,1,1),
                                        :status => 'Locked',
                                        :score => 5)

      @category_2 = PppamsCategoryBaseRef.make(:pppams_category_group => @category_1.pppams_category_group)
      @indicator_base_ref_2 = PppamsIndicatorBaseRef.make(:pppams_category_base_ref => @category_2)
      @indicator_2 = PppamsIndicator.make(:pppams_indicator_base_ref => @indicator_base_ref_2,
                                          :start_month => 1,
                                          :frequency => 2,
                                          :facility => @indicator_1.facility,
                                          :active_on => Date.new(2009,1,1),
                                          :inactive_on => nil)
      @review_2 = PppamsReview.make(:pppams_indicator => @indicator_2,
                                          :created_on => Date.new(2009,1,1),
                                          :status => 'Locked',
                                          :score => 6)

      @indicator_base_ref_3 = PppamsIndicatorBaseRef.make(:pppams_category_base_ref => @category_2)
      @indicator_3_cat_2 = PppamsIndicator.make(:pppams_indicator_base_ref => @indicator_base_ref_3,
                                          :start_month => 3,
                                          :frequency => 2,
                                          :facility => @indicator_1.facility,
                                          :active_on => Date.new(2009,1,1),
                                          :inactive_on => nil)
      @review_3_cat_2= PppamsReview.make(:pppams_indicator => @indicator_3_cat_2,
                                         :created_on => Date.new(2009,1,1),
                                         :score => 7,
                                        :status => 'Locked')
    end
    it 'should narrow search by facility' do
      PppamsIndicator.should_receive(:active_in_months).with(Date.today, Date.tomorrow, {:facility_ids => [1]}).and_return([])
      PppamsCategoryBaseRef.signature_summary_for_facility(1, Date.today, Date.tomorrow)
    end
    it 'should return a list of maximum reviews per category group' do
      results = PppamsCategoryBaseRef.signature_summary_for_facility(@indicator_1.facility_id,
                                                         Date.new(2009,1,1),
                                                         Date.new(2009,6,1))
      results.should == {@category_1.pppams_category_group_id => {
                                                                  :name => @category_1.pppams_category_group.name,
                                                                  :max_score => 30,
                                                                  :actual_score => 18,
                                                                  :percent => 60.0,
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
                                                                                     :max_score => 20,
                                                                                     :actual_score => 13,
                                                                                     :percent => 65.0,
                                                                                     :missing_reviews => false
                                                                                   }

                                                                                 ]
                                                                 },
                      :actual_score => 18,
                      :max_score => 30,
                      :percent => 60.0
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
  describe "self.max_review_sums" do
    before(:all) do
      active_indicators = [
                           stub( :facility_id => 3,
                                 :facility_name => 'fac_1',
                                 :pppams_category_base_ref_id => 4,
                                 :category_name => 'cat_1',
                                 :id => 5,
                                 :indicator_name => 'ind_1',
                                 :good_months => ':3:4:5:'
                              ),
                           stub( :facility_id => 3,
                                 :facility_name => 'fac_2',
                                 :pppams_category_base_ref_id => 9,
                                 :category_name => 'cat_3',
                                 :id => 10,
                                 :indicator_name => 'ind_3',
                                 :good_months => ':4:5:6:'
                              ),
                           stub( :facility_id => 6,
                                 :facility_name => 'fac_2',
                                 :pppams_category_base_ref_id => 7,
                                 :category_name => 'cat_2',
                                 :id => 8,
                                 :indicator_name => 'ind_2',
                                 :good_months => ':4:5:6:'
                              )

                          ]

      @results = PppamsCategoryBaseRef.max_review_sums(active_indicators, [3,4])
    end
    describe "for each facility" do
      it "sums the max scores and reviews" do
        @results[3][:max_score].should == 30
        @results[3][:max_reviews].should == 3
      end
      it "stores the facility's name" do
        @results[3][:name].should == 'fac_1'
        @results[6][:name].should == 'fac_2'
      end
      describe "'s category" do
        it "sums the max score and reviews" do
          @results[3][:categories][4][:max_score].should == 20
          @results[3][:categories][4][:max_reviews].should == 2
          @results[3][:categories][9][:max_score].should == 10
          @results[3][:categories][9][:max_reviews].should == 1
          @results[6][:categories][7][:max_score].should == 10
          @results[6][:categories][7][:max_reviews].should == 1
        end
        it ", stores its name" do
          @results[3][:categories][4][:name].should == 'cat_1'
          @results[3][:categories][9][:name].should == 'cat_3'
          @results[6][:categories][7][:name].should == 'cat_2'
        end
      end
      describe "'s indicator" do
        it 'sums the max score and reviews' do
          @results[3][:categories][4][:indicators][5][:max_score].should == 20
          @results[3][:categories][4][:indicators][5][:max_reviews].should == 2
          @results[3][:categories][9][:indicators][10][:max_score].should == 10
          @results[3][:categories][9][:indicators][10][:max_reviews].should == 1
          @results[6][:categories][7][:indicators][8][:max_score].should == 10
          @results[6][:categories][7][:indicators][8][:max_reviews].should == 1
        end
        it ', stores its name' do
          @results[3][:categories][4][:indicators][5][:name].should == 'ind_1'
          @results[3][:categories][9][:indicators][10][:name].should == 'ind_3'
          @results[6][:categories][7][:indicators][8][:name].should == 'ind_2'
        end
      end
    end
    describe "self.actual_review_sums for each facility" do
      before :all do
        facility_reviews = [
                    stub( :pppams_indicator_id => 1,
                          :score => 7),
                    stub( :pppams_indicator_id => 2,
                          :score => 9),
                    stub( :pppams_indicator_id => 2,
                          :score => 3),

                   ]
        @results = PppamsCategoryBaseRef.actual_review_sums(facility_reviews)
      end
      it "sums the actual scores and reviews" do
        @results[1][:actual_score].should == 7
        @results[1][:actual_reviews].should == 1
        @results[2][:actual_score].should == 12
        @results[2][:actual_reviews].should == 2
      end
    end
    describe "self.full_summary" do
      before :all do
        max_scores = ({
                     1 => {:name => 'fac_1',
                        :max_score => 40,
                        :max_reviews => 4,
                        :categories => { 
                          4 => { :max_score => 30,
                               :max_reviews => 3,
                               :name => 'cat_1',
                               :indicators => { 5 => { :name => 'ind_1', :max_score => 20, :max_reviews => 2, :no_reviews => false },
                                                6 => { :name => 'ind_2', :max_score => 10, :max_reviews => 1, :no_reviews => false }
                                }
                             },
                           7 => { :max_score => 10,
                               :max_reviews => 1,
                               :name => 'cat_2',
                               :indicators => { 8 => {:name => 'ind_3', :max_score => 10, :max_reviews => 1, :no_reviews => false }
                                }
                             },
                           9 => { :max_score => 10,
                               :max_reviews => 1,
                               :name => 'cat_3',
                               :indicators => { 4 => {:name => 'ind_3', :max_score => 10, :max_reviews => 1, :no_reviews => false }
                                }
                             }
                         }
                      }
                   })
        actual_scores =  {5 => {:actual_score => 7,
                                :actual_reviews => 1},
                          6 => {:actual_score => 7,
                                :actual_reviews => 1},
                          8 => {:actual_score => 7,
                                :actual_reviews => 1}
                         }

        @results = PppamsCategoryBaseRef.full_summary(actual_scores, max_scores)
      end
      it "should record the correct facility totals" do
        @results[1][:actual_score].should == 21
        @results[1][:actual_reviews] == 3
      end
      it "should record the percent based on actual_score / (actual_reviews*10)" do
        @results[1][:percent].should == ((21.0/30)*100).round(2)
      end
      it 'ignores indicators without any reviews by assigning zeros' do
        @results[1][:categories][9][:percent].should == 'N/A: No Reviews'
      end
    end
  end
end
