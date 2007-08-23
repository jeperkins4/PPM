class CustodyType < ActiveRecord::Base
  has_many :facility_custodies
  has_many :facilities, :through => :facility_custodies
end
