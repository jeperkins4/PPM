class PppamsReportFilter < ActiveRecord::Base

  serialize :facility_filter
  serialize :statius_filter
  serialize :category_filter
  serialize :indicator_filter


  def self.good_indicator_ids(base_filter)
	  filtered = {}
	  all = {:facilities => Facility.all(:select => [:id]).collect(&:id),
           :categories => PppamsCategoryBaseRef.all(:select => [:id]).collect(&:id),
           :indicators => PppamsIndicatorBaseRef.all(:select => [:id]).collect(&:id)
          }
	  cc = 0
	  group_level = 0

    #If a filter type (category, indicator or facility) does not
    #have any ids, include all ids of that filter type,
    #if it does have some ids, then increment the result group level.
	  base_filter.each do |filter_type, filter_ids| 

      #get uniq and valid number ids
      filter_ids= filter_ids.uniq_numerics

	    if filter_ids.size == 0 
		    base_filter[filter_type] = all[filter_type] 
      else 
		    result_group_levels = cc + 1 
	    end
      filtered[filter_type] = base_filter[filter_type]
      cc = cc + 1
    end

    #
    if filtered[:categories] == all[:categories] && filtered[:indicators] == all[:indicators]
      ind_string = filtered[:indicators].collect(&:to_i).flatten.uniq.join(",")

    elsif filtered[:categories] == all[:categories] && filtered[:indicators] != all[:indicators]
      ind_string = filtered[:indicators].collect{|i| i.to_i}.flatten.uniq.join(",")

    elsif filtered[:categories] != all[:categories] && filtered[:indicators] == all[:indicators]
      ind_string = PppamsCategoryBaseRef.find(filtered[:categories]).collect{|c| c.pppams_indicator_base_ref_ids}.flatten.uniq.join(",")

    else
      from_cats = PppamsCategoryBaseRef.find(filtered[:categories]).collect{|c| c.pppams_indicator_base_ref_ids}.flatten!
      all_inds = from_cats << filtered[:indicators].collect{|i| i.to_i}
      ind_string = all_inds.flatten.uniq.join(",")
    end
    fac_string = new_filter[0].collect{|i| i.to_i}.join(",")
    ouput = [PppamsIndicator.find(:all, 
                                  :joins => "inner join pppams_categories on pppams_categories.id = pppams_indicators.pppams_category_id",
                                  :conditions =>["pppams_indicator_base_ref_id in (#{ind_string}) 
                                                  and pppams_categories.facility_id in (#{fac_string})"]),
             group_level]
  end

  def self.good_reviews(from_date, to_date, status_filter, score_filter, good_ids)
    from_date = Time.now.beginning_of_month.strftime("%Y-%m-%d 00:00:00") if from_date == ''
    to_date = Time.now.end_of_month.strftime("%Y-%m-%d 23:59:59") if to_date == ''
    from_datetime = DateTime.parse(from_date).strftime("%Y-%m-%d 00:00:00")
    to_datetime = DateTime.parse(to_date).strftime("%Y-%m-%d 23:59:59")
    status_filter = ['Submitted','Review','Accepted','Locked',''] if status_filter.length == 0
    score_filter = (0..10).to_a if score_filter.length == 0
    ouput = PppamsReview.find(:all, 
                              :select => "pppams_reviews.*", 
                              :joins => ",pppams_indicators, pppams_categories", 
                              :order => "facility_id, pppams_category_id, pppams_indicator_id", 
                              :conditions =>["pppams_reviews.pppams_indicator_id = pppams_indicators.id 
                                              AND pppams_indicators.pppams_category_id = pppams_categories.id 
                                              AND pppams_indicator_id in (#{good_ids.join(',')}) 
                                              AND status in ('#{status_filter.join("','")}') 
                                              AND score in ('#{score_filter.join("','")}') 
                                              AND pppams_reviews.created_on <= '#{to_datetime}'
                                              AND pppams_reviews.created_on >= '#{from_datetime}'"])
    ouput2 = PppamsReview.find(:all, 
                               :select => "pppams_reviews.*",
                               :joins => ",pppams_indicators, pppams_categories", 
                               :conditions =>["pppams_reviews.pppams_indicator_id = pppams_indicators.id 
                                               AND pppams_indicators.pppams_category_id = pppams_categories.id 
                                               AND pppams_indicator_id in (#{good_ids.join(',')}) 
                                               and pppams_reviews.created_on <= '#{to_datetime}' 
                                               and pppams_reviews.created_on >= '#{from_datetime}'"])
    [ouput, ouput2]
  end

end
