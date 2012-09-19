class PppamsCategoryBaseRef < ActiveRecord::Base
  has_many :pppams_categories
  has_many :pppams_indicator_base_refs
  belongs_to :pppams_category_group

  attr_accessible :name, :pppams_category_group_id
end
