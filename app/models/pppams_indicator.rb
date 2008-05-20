class PppamsIndicator < ActiveRecord::Base
  belongs_to :pppams_category
  has_many :pppams_reviews
  has_and_belongs_to_many :pppams_references
  validates_presence_of [:question,:pppams_category_id,:frequency,:start_month, :good_months]
      
  def self.find_current(this_month, this_facility)   
    good_ids = "(#{this_facility.pppams_category_ids.join(',')})" 
    find_me = "%" + this_month.to_s + ":%"
    PppamsIndicator.find(:all, :order => 'pppams_category_id',:conditions => ["pppams_category_id in #{good_ids} AND good_months like ?",  find_me ])
  end  
  
  def status
    "Live"
  end
  
end
