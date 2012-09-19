require File.dirname(__FILE__) + '/../../spec_helper'

describe "summary_average report" do
  before(:each) do
    @show_from = assigns[:show_from] = Date.today
    @show_to = assigns[:show_to] = Date.tomorrow
    @filter = assigns[:filter] = {:category_filter => nil,
                        :indicator_filter => nil,
                        :facility_filter => nil,
                        :score_filter => nil,
                        :status_filter => nil
                       }
  end
  describe "results grouped by indicators" do
    before(:each) do
      @data = assigns[:data] = {
                           1 =>  #facility
                            {:name => '',
                             :categories =>
                             {1 => 
                              {:name => '',
                               :indicators => {}
                              }
                             }
                            }
                           }
    end
    it "should render the indicator grouping" do
      assigns[:grouping_type] = 'indicator_grouping'
      template.should_receive(:render).with(:partial => 'summary_criteria', 
                                            :locals => {:to => @show_to,
                                                        :from => @show_from,
                                                        :filter => @filter,
                                                        :filter_name => @filter_name,
                                                        :type => 'average scores'})
      template.should_receive(:render).with(:partial => 'indicator_grouping', 
                                            :locals => {:data => @data,
                                                        :sum_type => 'average_score'})

      render 'pppams_reports/summary_average'
    end
  end
end
