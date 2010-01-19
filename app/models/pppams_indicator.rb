class PppamsIndicator < ActiveRecord::Base
  belongs_to :pppams_indicator_base_ref
  belongs_to :facility
  has_many :pppams_reviews
  has_many :pppams_delinquent_reviews
  has_one :pppams_category_base_ref, :through => :pppams_indicator_base_ref
  has_and_belongs_to_many :pppams_references
  validates_presence_of [:pppams_indicator_base_ref_id,:frequency,:start_month, :good_months]
  validates_uniqueness_of :facility_id , :scope => :pppams_indicator_base_ref_id
  delegate :question, :to => :pppams_indicator_base_ref
  delegate :pppams_category_base_ref, :to => :pppams_indicator_base_ref
  delegate :pppams_category_base_ref_id, :to => :pppams_indicator_base_ref

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
                        :include => {:pppams_indicator_base_ref => :pppams_category_base_ref},
                        :order => 'pppams_category_base_refs.name')
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
      break
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
end
 
