require File.dirname(__FILE__) + '/../spec_helper'
describe "PppamsReview" do
  def retrieve_pristine_record(options = {})
    PppamsReview.with_indicators_and_date_range([@pppams_indicator.id],
                                                Date.new(2009,1,1),
                                                Date.new(2009,1,1),
                                                options)

  end
  before(:all) do
    PppamsReview.destroy_all
    @pppams_indicator = PppamsIndicator.make
    @pppams_review = PppamsReview.make(:created_on => Date.new(2009,1,1),
                                       :status => 'Locked',
                                       :pppams_indicator => @pppams_indicator,
                                       :score => 8)
  end
  describe "justification for scores" do
    it "should require notes for scores other than 7 or 8" do
     pppams_review = PppamsReview.make(:created_on => Date.new(2009,1,1),
                                       :status => 'Locked',
                                       :notes => nil,
                                       :pppams_indicator => @pppams_indicator,
                                       :score => 8)
      pppams_review.score = 9
      pppams_review.save.should == false
      pppams_review.errors.full_messages[0].should =~ /notes must be filled in/i
    end
  end
  describe "with_indicators_and_date_range should retrieve" do
    it "only those reviews with the provided indicators" do
      PppamsReview.make(:created_on => Date.new(2009,1,1),
                        :pppams_indicator => PppamsIndicator.make(:facility => @pppams_indicator.facility)
                       )
      retrieve_pristine_record.should have(1).record
    end
    it "only those reviews with created_on dates after the start date" do
      PppamsReview.make(:created_on => Date.new(2008,12,30),
                        :pppams_indicator => @pppams_indicator)
      retrieve_pristine_record.should have(1).record
    end

    it "only those reviews with created_on dates before the end date" do
      PppamsReview.make(:created_on => Date.new(2009,1,3),
                        :pppams_indicator => @pppams_indicator)

      retrieve_pristine_record.should have(1).record
    end
    it "only reviews matching given score" do
      PppamsReview.make(:created_on => Date.new(2009,1,1),
                        :pppams_indicator => @pppams_indicator,
                        :score => 7)
      retrieve_pristine_record({:score_values => 8}).should have(1).record
    end
    it "only reviews matching given status" do
      PppamsReview.make(:created_on => Date.new(2009,1,1),
                        :pppams_indicator => @pppams_indicator,
                        :status => 'Accepted')
      retrieve_pristine_record({:status_values => 'Locked'}).should have(1).record
    end


    it "the review's indicator_id" do
      retrieve_pristine_record[0].pppams_indicator_id.should == @pppams_indicator.id
    end
    it "the indicator's category_id IN STRING FORMAT" do
      retrieve_pristine_record[0].pppams_category_base_ref_id.should == @pppams_indicator.pppams_category_base_ref.id.to_s
    end
    it "the review's score" do
      retrieve_pristine_record[0].score.should == @pppams_review.score
    end
  end
end
