class AccountabilityLogs < ActiveRecord::Base
  belongs_to :facility

  def self.filtered_logs(start_date, end_date)
    logs = []
    date_range = (start_date..end_date).map{|d|{:month => d.month, :year => d.year}}.uniq
    date_range.each do |month_year|
      logs |= AccountabilityLogs.find(:all, :conditions => {:log_month => month_year[:month], :log_year => month_year[:year]})
    end
    return logs
  end
end
