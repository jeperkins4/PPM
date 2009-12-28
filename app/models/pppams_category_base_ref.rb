class PppamsCategoryBaseRef < ActiveRecord::Base
  has_many :pppams_categories
  has_many :pppams_indicator_base_refs
  belongs_to :pppams_category_group

  def to_s
    name
  end
end
