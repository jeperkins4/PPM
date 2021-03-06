class PppamsReportFilter < ActiveRecord::Base
  attr_accessible :category_filter, :created_by_id, :end_on, :facility_filter, :indicator_filter, :name, :report_type, :score_filter, :start_on, :status_filter, :updated_by_id

  serialize :facility_filter
  serialize :statius_filter
  serialize :category_filter
  serialize :indicator_filter


  def self.good_indicator_ids(user_filter)

    PppamsIndicator.find(:all) do
      any do
        pppams_indicator_base_ref.pppams_category_base_ref_id == user_filter[:categories] unless user_filter[:categories].empty?
        pppams_indicator_base_ref_id == user_filter[:indicators] unless user_filter[:indicators].empty?
        facility_id == user_filter[:facilities] unless user_filter[:facilities].empty?
      end

      active_on <= user_filter[:start_date]
      any do
        inactive_on == nil
        inactive_on >= user_filter[:end_date]
      end
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
