class PppamsCategory < ActiveRecord::Base
    belongs_to :facility
    belongs_to :pppams_category_base_ref
    has_many :pppams_indicators
    validates_presence_of [:name,:facility_id]
end
