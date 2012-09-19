<<<<<<< HEAD
class Investigator < ActiveRecord::Base
  belongs_to :facility

  attr_accessible :email, :entity, :facility_id, :firstname, :lastname, :phone

  delegate :name, :to => :facility, :prefix => true, :allow_nil => true
  
  def name
    [firstname,lastname].join(" ")
  end
end
=======
class Investigator < ActiveRecord::Base
  belongs_to :facility
end
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
