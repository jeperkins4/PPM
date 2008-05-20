class PppamsReview < ActiveRecord::Base
  
    include Userstamped
    
    belongs_to :pppams_indicator
    has_many :uploads
    
    belongs_to :created_by, :class_name => "User", :foreign_key => "created_by"
    belongs_to :updated_by, :class_name => "User", :foreign_key => "updated_by"

end
