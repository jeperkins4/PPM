class PppamsIndicator < ActiveRecord::Base
  belongs_to :pppams_category
  belongs_to :pppams_indicator_base_ref
  belongs_to :facility
  has_many :pppams_reviews
  has_many :pppams_delinquent_reviews
  has_and_belongs_to_many :pppams_references
  validates_presence_of [:pppams_indicator_base_ref_id,:frequency,:start_month, :good_months]
  validates_uniqueness_of :facility_id , :scope => :pppams_indicator_base_ref_id
  delegate :question, :to => :pppams_indicator_base_ref
  def self.find_current(this_date, this_facility)   
    if this_facility.pppams_started_on.nil? 
       return []
       break
    end
    good_ids = "(#{this_facility.pppams_category_ids.join(',')})" 
    find_me = "%:" + this_date.month.to_s + ":%"
    if this_facility.pppams_category_ids.size > 0 and this_date >= this_facility.pppams_started_on
      PppamsIndicator.find(:all, :order => 'pppams_category_id',:conditions => ["pppams_category_id in #{good_ids} AND good_months like ?",  find_me ])
    else
	[]
    end
  end 

  def current_review(this_month)  
    lowerlimit = this_month.beginning_of_month
    upperlimit = DateTime.parse(this_month.month.to_s + "/" + this_month.end_of_month.day.to_s + "/" + this_month.year.to_s + " 23:59:59")
    review = PppamsReview.find(:first, :conditions => ["created_on >= ? AND created_on <= ? and pppams_indicator_id = ?", lowerlimit, upperlimit, self.id])
  end

  def self.find_current_todo(this_month, this_facility)
    currents = PppamsIndicator.find_current(this_month, this_facility)
    if currents.length == 0 
      return [0,0]
      break
    end
    id_range = "(" + currents.collect {|x| x.id.to_s}.join(",") + ")"
    lowerlimit = this_month.beginning_of_month
    upperlimit = DateTime.parse(this_month.month.to_s + "/" + this_month.end_of_month.day.to_s + "/" + this_month.year.to_s + " 23:59:59")
    reviews = PppamsReview.find(:all, :conditions => ["created_on >= ? AND created_on <= ? and status = 'Locked' and pppams_indicator_id in #{id_range}", lowerlimit, upperlimit])
    return [reviews.length,currents.length] 
  end
  
  def set_good_months
    addme = [self.start_month]
    self.frequency.times { |f|
        if f > 0
            pushme = addme.last + f > 12 ?  addme.last + f  -12 : addme.last + f 
            addme.push(pushme)
        end
    }
    self.good_months = ":" + addme.join(':') + ":"
  end

end
 
