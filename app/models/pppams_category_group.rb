class PppamsCategoryGroup < ActiveRecord::Base
  has_many :pppams_category_base_refs
  def to_s
    name
  end
end
