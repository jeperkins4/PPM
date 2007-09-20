class Prompt < ActiveRecord::Base
  belongs_to :context
  
  validates_uniqueness_of :question
  validates_presence_of :context_id
end
