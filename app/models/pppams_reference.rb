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
