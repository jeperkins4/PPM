class Prompt < ActiveRecord::Base
  attr_accessible :id, :active, :context_id, :description, :question, :used_in_total
end
