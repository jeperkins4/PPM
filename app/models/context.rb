<<<<<<< HEAD
class Context < ActiveRecord::Base
  has_many :prompts
  attr_accessible :id, :shortname, :description, :position, :title

  validates_uniqueness_of :shortname

  def self.accountability(start_date,end_date)
    report = []
    months = []
    start_date.upto(end_date){|d| months << [d.month,d.year]}
    months = months.uniq
    self.where(:all).each do |category|
      questions = category.prompts.order('question')  
      filter_questions = category.prompts.where(:used_in_total => 1)
      questions.each do |question|
        sum = 0
        row_sum = 0
        notes = []
        column_sum = []
        months.each do |month,year|
          
        end
      end
    end
  end
end
=======
class Context < ActiveRecord::Base
  has_many :prompts
  validates_uniqueness_of :title
end
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
