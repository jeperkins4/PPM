class PppamsIndicatorBaseRef < ActiveRecord::Base
  has_many :pppams_indicators
  belongs_to :pppams_category_base_ref

  def short_question
    self.question[0,100] + "..."
  end

end
