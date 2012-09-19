<<<<<<< HEAD
class PppamsCategoryGroup < ActiveRecord::Base
  attr_accessible :name
end
=======
class PppamsCategoryGroup < ActiveRecord::Base
  has_many :pppams_category_base_refs
  def to_s
    name
  end
end
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
