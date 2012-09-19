<<<<<<< HEAD
class PppamsReference < ActiveRecord::Base
  attr_accessible :name, :url
end
=======
class PppamsReference < ActiveRecord::Base
  has_and_belongs_to_many :pppams_indicator_base_refs
  def html
    if self.url.nil?
      self.name
    else
      "<a href='" + self.url + "'>" + self.name + "</a>"
    end
  end
  
end
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
