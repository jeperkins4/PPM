class PppamsIndicator < ActiveRecord::Base
<<<<<<< HEAD
  attr_accessible :active_on, :facility_id, :frequency, :good_months, :inactive_on, :pppams_indicator_base_ref_id, :start_month
end
=======
  belongs_to :pppams_indicator_base_ref
  belongs_to :facility
  has_many :pppams_reviews
  has_many :pppams_delinquent_reviews
  has_one :pppams_category_base_ref, :through => :pppams_indicator_base_ref
  before_validation :set_good_months
  validates_presence_of [:pppams_indicator_base_ref_id,:frequency,:start_month, :good_months]
  validates_uniqueness_of :facility_id , :scope => :pppams_indicator_base_ref_id
  delegate :question, :to => :pppams_indicator_base_ref
  delegate :pppams_category_base_ref, :to => :pppams_indicator_base_ref
  delegate :pppams_category_base_ref_id, :to => :pppams_indicator_base_ref
  delegate :pppams_references, :to => :pppams_indicator_base_ref

  #Find indicators that are from the given facility
  #and whose facility started pppams after given date
  #and whose indicators are active as of the given date.
  def self.find_current(date, facility)   

    #The facility started recording pppams before the given date
    return [] if facility.pppams_started_on.nil? 
    return [] if facility.pppams_started_on > date

    PppamsIndicator.find(:all,
                         :conditions => ["facility_id = ?
                                          AND DATE(pppams_indicators.active_on) <= DATE(?)
                                          AND (
                                                DATE(pppams_indicators.inactive_on) >= DATE(?)
                                                OR
                                                pppams_indicators.inactive_on IS NULL
                                              )
                                          AND good_months LIKE ?",
                                         facility.id,
                                         date,
                                         date,
                                         "%:#{date.month}:%"],
                        :include => {:pppams_indicator_base_ref => [:pppams_category_base_ref, :pppams_references]},
                        :order => 'pppams_category_base_refs.name')
  end

  def self.active_in_months(start_date, end_date, options = {})

    return false if start_date <= PppamsReview::NEW_SCORE_CUTOFF and end_date > PppamsReview::NEW_SCORE_CUTOFF

    options = options.remove_blanks_in_arrays
    months_in_range = DateTime.all_months_between(start_date, end_date)
    find(:all, :select => 'pppams_indicators.id,
                           pppams_indicator_base_ref_id,
                           pppams_indicator_base_refs.question as indicator_name,
                           pppams_category_base_ref_id,
                           pppams_category_base_refs.name as category_name,
                           pppams_indicators.good_months,
                           pppams_indicators.facility_id,
                           facilities.facility as facility_name',
               :joins => "INNER JOIN pppams_indicator_base_refs on pppams_indicators.pppams_indicator_base_ref_id = pppams_indicator_base_refs.id
                          INNER JOIN pppams_category_base_refs on pppams_indicator_base_refs.pppams_category_base_ref_id = pppams_category_base_refs.id
                          INNER JOIN facilities on facilities.id = pppams_indicators.facility_id") do
      any do
        months_in_range.each do |m|
          good_months =~ '%:'+m.to_s+':%'
        end
      end

      active_on <= start_date
      any do
        inactive_on == nil
        inactive_on >= end_date.end_of_day
      end

      #Even if the options is an array, this will work.
      #We cleaned up and cleared out arrays earlier with remove_blanks_and_empties.
      pppams_indicator_base_ref_id == options[:pppams_indicator_base_ref_ids] unless options[:pppams_indicator_base_ref_ids].blank?
      facility_id                  == options[:facility_ids]                   unless options[:facility_ids].blank?
      pppams_indicator_base_ref.pppams_category_base_ref_id  == options[:pppams_category_base_ref_ids]  unless options[:pppams_category_base_ref_ids].blank?
    end
  end

  def current_review(this_month)  
    lowerlimit = this_month.beginning_of_month
    upperlimit = this_month.to_time.end_of_month
    review = PppamsReview.find(:first, 
                               :conditions => ["DATE(created_on) >= DATE(?) AND DATE(created_on) <= DATE(?) and pppams_indicator_id = ?",
                                               lowerlimit, 
                                               upperlimit, 
                                               self.id])
  end

  # Find the total number of reviews that are locked 'this month', for 'this_facility'
  # => [num_reviews_completed, num_indicators_total_this_month]
  def self.find_current_todo(this_month, this_facility)
    currents = PppamsIndicator.find_current(this_month, this_facility)
    if currents.length == 0 
      return [0,0]
#      break
    end
    id_range = "(" + currents.collect {|x| x.id.to_s}.join(",") + ")"
    lowerlimit = this_month.beginning_of_month
    upperlimit = this_month.to_time.end_of_month
    reviews = PppamsReview.find(:all, 
                                :conditions => ["DATE(created_on) >= DATE(?) AND DATE(created_on) <= DATE(?) and status = 'Locked' and pppams_indicator_id in #{id_range}",
                                  lowerlimit, 
                                  upperlimit])
    return [reviews.length,currents.length] 
  end

  def self.with_report_criteria_matching(user_filter)

    indicator_ids = find(:all, :select => [:id]) do
      unless user_filters[:indicators].empty? && user_filters[:categories].empty?
        any do
          pppams_indicator_base_ref.pppams_category_base_ref_id == user_filter[:categories] unless user_filter[:categories].empty?
          pppams_indicator_base_ref_id == user_filter[:indicators] unless user_filter[:indicators].empty?
        end
      end

      facility_id == user_filter[:facilities] unless user_filter[:facilities].empty?

      active_on <= user_filter[:start_date]
      any do
        inactive_on == nil
        inactive_on >= user_filter[:end_date]
      end
    end

  end

 
  def set_good_months
    good_months_array = [self.start_month]
    review_interval = 12/self.frequency
    (self.frequency - 1).times { |f|
            next_good_month = good_months_array.last + review_interval > 12 ?
                       good_months_array.last + review_interval  -12 : 
                       good_months_array.last + review_interval 
            good_months_array.push(next_good_month)
    }
    self.good_months = ":" + good_months_array.join(':') + ":"
  end

  def update_good_months(start_month, frequency)
    self.start_month = start_month.to_i
    self.frequency = frequency.to_i
    set_good_months
  end

  def self.new_standard_for_facility(facility_id, base_indicator_id)
    create!( :good_months => ':1:',
             :frequency => 1,
             :active_on => nil,
             :start_month => 1,
             :facility_id => facility_id,
             :pppams_indicator_base_ref_id => base_indicator_id
           )
  end
end
 
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
