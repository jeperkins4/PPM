class ActionType < ActiveRecord::Base
  has_many :incidents
  attr_accessible :id, :description, :name
end
