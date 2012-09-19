class Position < ActiveRecord::Base
  belongs_to :position_type
  has_many :position_numbers
  has_many :position_hists
  validates_presence_of [:title, :salary, :position_type_id]
  validates_uniqueness_of :title, :scope => :position_type_id

  def facility
    self.position_type.facility
  end
  
  attr_accessible :id, :description, :position_type_id, :salary, :title

  def name
    title
  end
end
