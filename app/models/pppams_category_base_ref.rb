require 'activesupport'

class PppamsCategoryBaseRef < ActiveRecord::Base
  has_many :pppams_categories
  has_many :pppams_indicator_base_refs
  belongs_to :pppams_category_group

  def to_s
    name
  end

  #from start_date, end_date and filter options,
  #creates a summary hash of the form:
  #  {1 =>  #facility_id
  #    {:name => 'facility_name',
  #     :percent => float_percent
  #     :categories =>
  #     {1 => 
  #      {:name => 'category_name',
  #       :indicators => 
  #       {1 =>
  #        {:name => 'indicator_name',
  #         :percent => float_percent
  #        }
  #       }
  #      }
  #     }
  #    }
  #   }
  def self.indicator_summary_between(start_date, end_date, options = {})
    months_in_range = DateTime.all_months_between(start_date, end_date)

    # Note that this safely ignores 'options' that are not relevant to finding an indicator.
    active_indicators_in_range = PppamsIndicator.active_in_months(start_date, end_date, options)

    active_indicator_ids = active_indicators_in_range.map(&:id)

    # Note that this safely ignores 'options' that are not relevant to finding a review.
    reviews_matching_criteria = PppamsReview.with_indicators_and_date_range(active_indicator_ids,
                                                                            start_date,
                                                                            end_date,
                                                                            options)

    max_scores    = max_review_sums(active_indicators_in_range, months_in_range)

    actual_scores = actual_review_sums(reviews_matching_criteria)

    full_summary(actual_scores, max_scores)

  end
  def self.review_summary(start_date, end_date, options = {})
    months_in_range = DateTime.all_months_between(start_date, end_date)

    # Note that this safely ignores 'options' that are not relevant to finding an indicator.
    active_indicators = PppamsIndicator.active_in_months(start_date, end_date, options)

    active_indicator_ids = active_indicators.map(&:id)

    # Note that this safely ignores 'options' that are not relevant to finding a review.
    reviews_matching_criteria = PppamsReview.with_indicators_and_date_range(active_indicator_ids,
                                                                            start_date,
                                                                            end_date,
                                                                            options.merge({:full_review => true}))


    reviews_matching_criteria.inject({}) do |full_review, review|

      active_indicator = active_indicators.select {|indicator| indicator.id = review.pppams_indicator_id }[0]

      facility = full_review[active_indicator.facility_id] ||= {:name => active_indicator.facility_name,
                                                               :categories => {}
                                                              }

      category = facility[:categories][active_indicator.pppams_category_base_ref_id] ||= {
                                                               :name => active_indicator.category_name,
                                                               :reviews => {}
                                                              }
      current_review = category[:reviews][review.id] ||= {
                                                               :indicator_name => active_indicator.indicator_name,
                                                              }
      [:observation_ref,
       :documentation_ref,
       :interview_ref,
       :evidence,
       :status,
       :notes,
       :real_creation_date,
       :created_on,
       :score
      ].each {|attr| current_review[attr] = review.send(attr) }

      full_review
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
  def self.signature_summary_for_facility(facility_id, start_date, end_date)

    months_in_range = DateTime.all_months_between(start_date, end_date)

    active_indicators_in_range = PppamsIndicator.active_in_months(start_date, end_date, {:facility_ids => [facility_id]})

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
          elsif category[:percent] != 'na'
            group[:max_score] = 0
            group[:actual_score] = 0
          end
        end
        #debugger if group[:name] =~ /inmate programs/i
        if group[:max_score] == 0
          group[:percent] = 'na'
        else
          group[:percent] = ((group[:actual_score].to_i.to_f / group[:max_score])*100).round(1)
        end
      end
    end
    full_summary[:max_score] == 0 ? full_summary[:percent] = 0 : full_summary[:percent] = ((full_summary[:actual_score].to_i.to_f / full_summary[:max_score])*100).round(1)
    full_summary
  end

  #from indicators and months in a range,
  #get a hash of the form
  # {facility_id => {:name => facility_name,
  #                  :max_score => 123,
  #                  :max_reviews => 123,
  #                  :categories =>   {category_id => {:max_score => 123,
  #                                                    :max_reviews => 123,
  #                                                    :name => category_name
  #                                                    :indicators => {indicator_id => {:name => indicator_name,
  #                                                                                      :max_score => 123,
  #                                                                                      :max_reviews => 123,
  #                                                                                      :no_reviews => true/false
  #                                                                                     }
  #                                                                    }
  #                                                   }
  #                                   }
  #                 }, 
  #  facility_id => ...
  # }
  def self.max_review_sums(active_indicators, months_in_range)
    active_indicators.inject({}) do |max_scores, active_indicator|

      facility = max_scores[active_indicator.facility_id] ||= {:name => active_indicator.facility_name,
                                                               :max_score => 0,
                                                               :max_reviews => 0,
                                                               :categories => {}
                                                              }

      category = facility[:categories][active_indicator.pppams_category_base_ref_id] ||= {
                                                               :name => active_indicator.category_name,
                                                               :max_score => 0,
                                                               :max_reviews => 0,
                                                               :indicators => {}
                                                              }
      indicator = category[:indicators][active_indicator.id] ||= {
                                                               :name => active_indicator.indicator_name,
                                                               :max_score => 0,
                                                               :max_reviews => 0,
                                                               :no_reviews => false
                                                              }

      months_in_indicator = active_indicator.good_months.split(':').uniq.reject {|month| month.blank?}
      months_in_indicator.map!(&:to_i)

      months_in_indicator_intersecting_months_in_range = (months_in_indicator & months_in_range).size

      if months_in_indicator_intersecting_months_in_range > 0 

        additional_score = (months_in_indicator_intersecting_months_in_range*10)
        additional_reviews = months_in_indicator_intersecting_months_in_range
        [facility, category, indicator].each do |item|
          item[:max_score] = item[:max_score] + additional_score
          item[:max_reviews] = item[:max_reviews] + additional_reviews
        end
      else
        indicator[:no_reviews] = true
      end
      max_scores
    end
  end

  # From a set of facility reviews, sum up the scores and
  # organize by indicator_id like so:
  # {indicator_id1 => {:actual_score => 123,
  #                    :actual_reviews => 123},
  #  indicator_id2 => {:actual_score => 123,
  #                    :actual_reviews => 123}
  # }
  def self.actual_review_sums(facility_reviews)
        facility_reviews.inject({}) do |actual_scores, review|

          actual_scores[review.pppams_indicator_id] ||= {:actual_score => 0,
                                                         :actual_reviews => 0}
          actual_scores[review.pppams_indicator_id][:actual_score] += review.score
          actual_scores[review.pppams_indicator_id][:actual_reviews] += 1

          actual_scores
        end
  end

  def self.full_summary(actual_scores, max_scores)
    max_scores.each do |facility_id, facility|
      if facility_id.instance_of?(Fixnum)
        max_scores[facility_id] = category_summaries(facility, actual_scores)
      end
    end
  end

  def self.category_summaries(facility, actual_scores)
    facility[:categories].each do |category_id, category|
      category = indicator_summaries(category, actual_scores)
      score = category[:actual_score]
      reviews = category[:actual_reviews]

      facility[:actual_score] ||= 0
      facility[:actual_score] += score unless score.to_i <= 0

      facility[:actual_reviews] ||= 0
      facility[:actual_reviews] += reviews unless reviews.to_i <= 0
      facility[:missing_reviews] = true if category[:missing_reviews]

      if facility[:actual_reviews] > 0
        facility[:percent] = percent(facility[:actual_score], facility[:actual_reviews]*10)
      end
    end
    facility
  end

  def self.indicator_summaries(category, actual_scores)
    category[:indicators].each do |indicator_id, indicator|
      category_indicator = category[:indicators][indicator_id]
      if actual_scores[indicator_id]
        category_indicator.merge!(actual_scores[indicator_id])
        category_indicator[:percent] = percent(category_indicator[:actual_score], category_indicator[:actual_reviews]*10) unless category_indicator[:actual_reviews] == 0
        category_indicator[:missing_reviews] = (category_indicator[:actual_reviews] < category_indicator[:max_reviews])
      else
        category_indicator.merge!({:actual_score => 0, :actual_reviews => 0, :percent => 'N/A: No Reviews', :missing_reviews => true})
      end
      score = category_indicator[:actual_score]
      reviews = category_indicator[:actual_reviews]

      category[:actual_score] ||= 0
      category[:actual_score] += score unless score.to_i <= 0

      category[:actual_reviews] ||= 0
      category[:actual_reviews] += reviews unless reviews.to_i <= 0
      category[:missing_reviews] = (category[:actual_reviews].to_i < category[:max_reviews].to_i)

      if category[:actual_reviews].to_i <= 0
        category[:percent] = 'N/A: No Reviews'
      else
        category[:percent] = percent(category[:actual_score], category[:actual_reviews]*10)
      end
    end
    category
  end

  def self.percent(divide_me, by_bigger)
    ((divide_me.to_f / by_bigger)*100).round(2)
  end
end
