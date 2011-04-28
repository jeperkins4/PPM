class AccessLevel < ActiveRecord::Base

  def self.facility
    find(2)
  end
  def self.admin
    find(1)
  end
end
