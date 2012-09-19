class Prompt < ActiveRecord::Base
  belongs_to :context
  validates_uniqueness_of :question
  validates_presence_of :context_id
  attr_accessible :id, :active, :context_id, :description, :question, :used_in_total
end
