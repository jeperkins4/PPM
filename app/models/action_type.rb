<<<<<<< HEAD
class ActionType < ActiveRecord::Base
  attr_accessible :id, :description, :name
end
=======
class ActionType < ActiveRecord::Base
  has_many :incidents
end
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
