<<<<<<< HEAD
class AccessLevel < ActiveRecord::Base
  has_many :user_types

  attr_accessible :id, :description, :name
end
=======
class AccessLevel < ActiveRecord::Base

  def self.facility
    find(2)
  end
  def self.admin
    find(1)
  end
end
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
