class Report
  def self.accountability(start_date,end_date,options={})
    report = []
    months = []
    start_date.upto(end_date){|d| months << [d.month,d.year]}
    months = months.uniq
    if options[:facility_id].blank?
      logs = AccountabilityLog.joins(:prompt).where('logged_at >= ? and logged_at <= ?',start_date, end_date).order([:log_year, :log_month]).group_by(&:prompt_id)
    else 
      logs = AccountabilityLog.joins(:prompt).where('facility_id = ? and logged_at >= ? and logged_at <= ?',options[:facility_id], start_date, end_date).order([:log_year, :log_month]).group_by(&:prompt_id)
    end
   
    Context.all(:order => 'title').each do |category|
      questions = category.prompts.order('question')  
      filter_questions = category.prompts.where(:used_in_total => true)
      prompts = []
      questions.each do |question|
        sum = 0
        row_sum = 0
        notes = []
        column_sum = []
        monthly = []
        months.each do |month,year|
          if options[:facility_id] == 'All' || options[:facility_id].blank?
            #count = AccountabilityLog.where(:log_month => month, :log_year => year, :prompt_id => question.id).first.response.to_f rescue 0 
            unless logs[question.id].nil?
              matches = logs[question.id].select{|l|l.log_month == month && l.log_year == year}
              count = matches.map{|l|l.response.to_f}.inject(:+) rescue 0
            else
              count = 0
            end
            row_sum += count.to_f
            column_count = 0
            filter_questions.map(&:id).each do |q|
              column_count += logs[q].map{|f|f.response.to_f}.reduce(:+)
            end
            column_sum << column_count
            #column_sum << AccountabilityLog.where(:log_month => month, :log_year => year, :prompt_id => filter_questions.map(&:id)).map{|f|f.response.to_f}.reduce(:+) 
            notes << AccountabilityLogDetail.where(:context_id => category.id, :log_month => month, :log_year => year)
          else
            unless logs[question.id].nil?
              matches = logs[question.id].select{|l|l.log_month == month && l.log_year == year}
              count = matches.map{|l|l.response.to_f}.inject(:+) rescue 0
            else
              count = 0
            end
            row_sum += count.to_f
            column_sum << AccountabilityLog.where(:facility_id => options[:facility_id], :log_month => month, :log_year => year, :prompt_id => filter_questions.map(&:id)).map{|f|f.response.to_f}.reduce(:+) 
            notes << AccountabilityLogDetail.where(:facility_id => options[:facility_id], :context_id => category.id, :log_month => month, :log_year => year)

          end
          #debugger
          monthly << {:month => month, :year => year, :count => count}
        end # End Months
        prompts << {:question => question.question, :used_in_total => question.used_in_total, :row_sum => row_sum, :column_sum => column_sum, :notes => notes, :monthly => monthly}
      end # End Questions
      report << {:title => category.title, :prompts => prompts}
    end # End Context
    return report, months
  end
end
