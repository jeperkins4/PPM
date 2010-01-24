require 'activesupport'

class PppamsCategoryBaseRef < ActiveRecord::Base
  has_many :pppams_categories
  has_many :pppams_indicator_base_refs
  belongs_to :pppams_category_group

  def to_s
    name
  end

  #from max_scores and actual_scores, get a hash of the form:
  # {category_group_id => {:name => group_name,
  #                        :max_score => sum_of_max_scores,
  #                        :actual_score => sum_of_actual_scores,
  #                        :percent => max/actual,
  #                        :categories => [{:name => category_name,
  #                                         :max_score => category_max_score,
  #                                         :actual_score => ...,
  #                                         :percent => ...
  #                                        },
  #                                        {:name => another_category_name,
  #                                         :max_score => ...
  #                                         ...
  #                                        }
  #                                       ],
  #                       {:name => next_group_name
  #                        ...
  #  :percent => 63.33
  def self.summary_for_facility_between(facility_id, start_date, end_date)

    months_in_range = DateTime.all_months_between(start_date, end_date)

    active_indicators_in_range = PppamsIndicator.active_in_months(facility_id, start_date, end_date)

    active_indicator_ids = active_indicators_in_range.map(&:id)

    facility_reviews_in_date_range_valid_status = PppamsReview.with_indicators_and_date_range(active_indicator_ids,
                                                                                            start_date,
                                                                                            end_date)

    max_scores    = category_max_review_sums(active_indicators_in_range, months_in_range)

    actual_scores = category_actual_review_sums(facility_reviews_in_date_range_valid_status)



    #Generate hash of sums and percents
    calculate_sums_and_percents(actual_scores, max_scores)

   end

    #get a hash of the form
    # {category_id => {:max_score => 123,
    #                  :max_reviews => 123
    #                 },
    #  category_id => {:max_score => 123,
    #                  :max_reviews => 123
    #                 }
    # }
  def self.category_max_review_sums(active_indicators, months_in_range)
    active_indicators.inject({}) do |max_scores, active_indicator|

      months_in_indicator = active_indicator.good_months.split(':').uniq.reject {|month| month.blank?}
      months_in_indicator.map!(&:to_i)

      category = active_indicator.pppams_category_base_ref_id

      months_in_indicator_intersecting_months_in_range = (months_in_indicator & months_in_range).size

      max_scores[category] ||= {:max_score => 0,
                                :max_reviews => 0}
      max_scores[category][:max_score] += (months_in_indicator_intersecting_months_in_range*10)
      max_scores[category][:max_reviews] += (months_in_indicator_intersecting_months_in_range)

      max_scores
    end

  end

   #given an array of reviews (with their corresponding category_base_ref_id)
   #get a hash with the reviews' sums  grouped by category like so:
   # {category_id => {:actual_score => 123,
   #                  :actual_reviews => 123},
   #  category_id => {:actual_score => 123,
   #                  :actual_reviews => 123},
   #  ...
   # }
  def self.category_actual_review_sums(facility_reviews_with_category_id)
    facility_reviews_with_category_id.inject({}) do |actual_scores, review|

      category = review.pppams_category_base_ref_id.to_i

      actual_scores[category] ?
        actual_scores[category] = {:actual_score => actual_scores[category][:actual_score] + review.score.to_i,
                                   :actual_reviews => actual_scores[category][:actual_reviews] + 1} :
        actual_scores[category] = {:actual_score => review.score.to_i,
                                   :actual_reviews => 1}

      actual_scores
    end
  end

  #from max_scores and actual_scores, get a hash of the form:
  # {category_group_id => {:name => group_name,
  #                        :max_score => sum_of_max_scores,
  #                        :actual_score => sum_of_actual_scores,
  #                        :percent => max/actual,
  #                        :categories => [{:name => category_name,
  #                                         :max_score => category_max_score,
  #                                         :actual_score => ...,
  #                                         :percent => ...
  #                                        },
  #                                        {:name => another_category_name,
  #                                         :max_score => ...
  #                                         ...
  #                                        }
  #                                       ],
  #                       {:name => next_group_name
  #                        ...
  #  :percent => 63.33

  def self.calculate_sums_and_percents(actual_scores, max_scores)
    categories_and_groups = find(:all, :select => 'pppams_category_base_refs.name as category_name,
                                                   pppams_category_groups.name as group_name,
                                                   pppams_category_group_id as group_id,
                                                   pppams_category_base_refs.id as id',
                                       :joins => [:pppams_category_group])
    #Iterate through each category,
    #constructing summary hash as we go
    full_summary = categories_and_groups.inject({}) do |full_summary, category|
      group_id = category.group_id.to_i
      full_summary[group_id] ||= {:name => category.group_name,
                                           :max_score => 0,
                                           :actual_score => 0,
                                           :percent => 0,
                                           :categories => []
                                          }
      group = full_summary[group_id]

      #if the category has indicators with reviews for the given months
      #go ahead, otherwise, assign blanks.
      unless max_scores[category.id].nil?
        max = max_scores[category.id][:max_score].to_i
        actual = actual_scores[category.id].try(:fetch, :actual_score).to_i
        max > 0 ? percent = ((actual.to_f/max)*100).to_f.round(1) : percent = 0

        #Make sure we return something if we're missing some reviews.
        if actual_scores[category.id].nil? ||
          max_scores[category.id][:max_reviews].to_i > actual_scores[category.id][:actual_reviews] then
          missing_reviews = true
          percent = 'na'
        else
          missing_reviews = false
        end

        group[:categories] << {:name => category.category_name,
                               :max_score => max || 0,
                               :actual_score => actual || 0,
                               :percent => percent || 0,
                               :missing_reviews => missing_reviews}
      else
        #Assign na if there's no max score for this category
        group[:categories] << {:name => category.category_name,
                               :max_score => 0,
                               :actual_score => 0,
                               :percent => 'na',
                               :missing_reviews => false}
      end
      full_summary
    end
    assign_group_sums_and_totals(full_summary)
  end

  def self.assign_group_sums_and_totals(full_summary)
    full_summary[:max_score] = 0
    full_summary[:actual_score] = 0

    full_summary.each do |group_id, group|
      if group_id.instance_of?(Fixnum)
        group[:categories].each do |category|
          if !category[:missing_reviews] && category[:percent] != 'na'
            group[:max_score] += category[:max_score]
            group[:actual_score] += category[:actual_score]
            full_summary[:max_score] += category[:max_score]
            full_summary[:actual_score] += category[:actual_score]
          else
            group[:max_score] = 0
            group[:actual_score] = 0
          end
        end

        if group[:max_score] == 0 || group[:max_score].nil?
          group[:percent] = 'na'
        else
          group[:percent] = ((group[:actual_score].to_i.to_f / group[:max_score])*100).round(1)
        end
      end
    end
    full_summary[:max_score] == 0 ? full_summary[:percent] = 0 : full_summary[:percent] = ((full_summary[:actual_score].to_i.to_f / full_summary[:max_score])*100).round(1)
    full_summary
  end
end
