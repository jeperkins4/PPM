class Position < ActiveRecord::Base
  attr_accessible :id, :description, :position_type_id, :salary, :title

  def name
    title
  end
end

