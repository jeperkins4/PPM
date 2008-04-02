class PppamsIndicator < ActiveRecord::Base
      belongs_to :pppams_category
      validates_presence_of [:reference,:description,:pppams_category_id,:frequency,:indicator_rating,:max_score,:start_month]
end
