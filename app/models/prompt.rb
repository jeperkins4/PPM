<<<<<<< HEAD
class Prompt < ActiveRecord::Base
  attr_accessible :id, :active, :context_id, :description, :question, :used_in_total
end
=======
class Prompt < ActiveRecord::Base
  belongs_to :context
  
  validates_uniqueness_of :question
  validates_presence_of :context_id
end
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
