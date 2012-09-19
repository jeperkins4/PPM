<<<<<<< HEAD
class PositionType < ActiveRecord::Base
  has_many :positions
  attr_accessible :id, :name, :description, :deductable, :deduction_days, :facility_id
end
=======
class PositionType < ActiveRecord::Base
  belongs_to :facility
  has_many :positions
  validates_presence_of :facility_id
end
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
