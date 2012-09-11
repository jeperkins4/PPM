class AccountabilityLog < ActiveRecord::Base
  belongs_to :facility
  belongs_to :prompt

  attr_accessible :context_id, :facility_id, :log_month, :log_year, :logged_at, :prompt_id, :response

  def self.filtered_logs(start_date, end_date)
    logs = []
    # TODO this can be improved
    date_range = (start_date..end_date).map{|d|{:month => d.month, :year => d.year}}.uniq
    date_range.each do |month_year|
      logs |= AccountabilityLogs.find(:all, :conditions => {:log_month => month_year[:month], :log_year => month_year[:year]})
    end
    return logs
  end
end
