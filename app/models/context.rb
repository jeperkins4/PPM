class Context < ActiveRecord::Base
  has_many :prompts
  validates_uniqueness_of :title
end
