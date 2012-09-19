class PppamsCategoryGroup < ActiveRecord::Base
  has_many :pppams_category_base_refs
  attr_accessible :name
end
