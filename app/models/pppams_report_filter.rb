class PppamsReportFilter < ActiveRecord::Base

  serialize :facility_filter
  serialize :statius_filter
  serialize :category_filter
  serialize :indicator_filter


    def self.good_indicator_ids(base_filter)
	new_filter = []
	all_ids = []
	all_ids << Facility.find(:all).collect{|x| x.id}
	all_ids << PppamsCategoryBaseRef.find(:all).collect{|x| x.id}
	all_ids << PppamsIndicatorBaseRef.find(:all).collect{|x| x.id}
	cc = 0
	group_level = 3
	base_filter.each do |x| 
           x.uniq!
           rubbish = x.pop
	    if x.empty? 
		x = all_ids[cc] 
		group_level = cc if group_level == 3
	    end
           new_filter << x
           cc = cc + 1
       end
	from_cats = PppamsCategoryBaseRef.find(new_filter[1]).collect{|c| c.pppams_indicator_base_ref_ids}.flatten!
       all_inds = from_cats << new_filter[2].collect{|i| i.to_i}
	fac_string = new_filter[0].collect{|i| i.to_i}.join(",")
	ind_string = all_inds.flatten.uniq.join(",")
       ouput = [PppamsIndicator.find(:all, :include => :pppams_category, :conditions =>["pppams_indicator_base_ref_id in (#{ind_string}) and facility_id in (#{fac_string})"]).collect{|i| i.id}, group_level]
    end

    def self.good_reviews(from_date, to_date, status_filter, good_ids)
       from_date = Time.now.beginning_of_month.strftime("%Y-%m-%d") if from_date.empty?
       to_date = Time.now.end_of_month.strftime("%Y-%m-%d") if to_date.empty?
       from_datetime = DateTime.parse(from_date).strftime("%Y-%m-%d")
       to_datetime = DateTime.parse(to_date).strftime("%Y-%m-%d")
       status_filter = ['Submitted','Review','Accepted','Locked',''] if status_filter.empty?
       ouput = PppamsReview.find(:all, :select => "pppams_reviews.*", :joins => ",pppams_indicators, pppams_categories", :order => "facility_id, pppams_category_id, pppams_indicator_id", :conditions =>["pppams_reviews.pppams_indicator_id = pppams_indicators.id AND pppams_indicators.pppams_category_id = pppams_categories.id AND pppams_indicator_id in (#{good_ids.join(',')}) and status in ('#{status_filter.join("','")}') and pppams_reviews.created_on <= '#{to_datetime}' and pppams_reviews.created_on >= '#{from_datetime}'"])
    end

end