class PositionReportsController < ApplicationController
  layout 'administration'    
  
  def index
    @now = Time.now
    @criteria_date = @now.last_month
    
    if request.post?
      unless params[:id] == ""
        session[:report_selection] = params[:id][:selection]
        
        case session[:report_selection]
        when "Lateral Move"
          @results = 'lateral_move'
          lateral_move
        when "Vacancy"
          @results = 'vacancy'
          vacancy
        end
      end
    end
    
  end
  
  
  def vacancy
    #Find deductable types by the current facility for user
    @deductable_position_type = PositionType.find(:all, :conditions => ['deductable = ?', 1])
    
    #Find deductable Positions based on the types
    @deductable_positions = Position.find(:all, :conditions => ['position_type_id IN (?) and facility_id = ?', @deductable_position_type, session[:facility].id])
    
    #Now get the position numbers tied to the position types found above
    if @deductable_positions != nil
      @deductable_position_numbers = PositionNumber.find(:all, :conditions => ['position_id IN (?) AND position_type = ? and waiver_approval_date is null', @deductable_positions, "none"])        
    end    
    
    
    #Find all deductable historic positions that fall outside the acceptable period 
    # of days because they have not been filled yet as of report run time
    @deductable_historic_position_numbers = EmployeePositionHist.find(:all, 
                                                                      :select =>'DISTINCT position_number_id as id',
    :conditions =>['position_number_id IN (?)',@deductable_position_numbers])
    
    @newly_assigned_with_deductions = []   
    
    if @deductable_historic_position_numbers.empty?
      @deductable_historic_position_numbers = ""
    end
    
    @deductable_position_numbers.each do |dpn|
      @newly_assigned_with_deductions += EmployeePosition.find(:all, :from=>'employee_positions a, position_numbers b', :conditions=>['a.position_number_id = b.id 
                                                                            and a.position_number_id = ? and DATEDIFF(a.start_date, b.created_on) > ? AND start_date > DATE_ADD(LAST_DAY(?),
                                                                            INTERVAL 1 DAY) and start_date <= LAST_DAY(?) AND a.position_number_id not in (?)',
      dpn.id, dpn.position.position_type.deduction_days, 2.months.ago, @criteria_date, @deductable_historic_position_numbers])
    end
    
    #Find all deductable current positions that fall outside the acceptable period of days
    #inlcuding newly created positions
    if @newly_assigned_with_deductions.empty?
      @newly_assigned_with_deductions = ""
    end
    
    @deductable_current_position_numbers = EmployeePosition.find(:all, 
                                                                 :select =>'DISTINCT position_number_id as id, position_number_id',
    :conditions =>['(position_number_id IN (?) AND position_number_id not in (?))
                                           AND start_date <= LAST_DAY(?)',
    @deductable_position_numbers, @newly_assigned_with_deductions, @criteria_date])
    
    
    
    
    
    if @deductable_current_position_numbers.empty?
      @deductable_current_position_numbers = ""
    end
    
    if @deductable_historic_position_numbers.empty?
      @deductable_historic_position_numbers = ""
    end
    
    if @newly_assigned_with_deductions.empty?
      @newly_assigned_with_deductions = ""
    end
    
    #Find all deductable positions that have been created but never filled at least once
    @not_assigned =PositionNumber.find(:all, 
                                       :conditions => ['(id not in(?) AND id not in (?) and id not in (?)) and id in (?)', 
    @deductable_current_position_numbers, 
    @deductable_historic_position_numbers,
    @newly_assigned_with_deductions,
    @deductable_position_numbers])
    
    
    
    @history_with_current = []
    
    # @history_with_current = EmployeePositionHist.find(:all, :select => 'DISTINCT position_number_id',:conditions =>['position_number_id IN (?)',@deductable_current_position_numbers])
    @history_without_current  = EmployeePositionHist.find(:all, 
                                                          :select => 'DISTINCT position_number_id',
    :conditions =>['position_number_id IN (?) AND position_number_id NOT IN (?)',
    @deductable_position_numbers, @deductable_current_position_numbers ])
    
    @current_with_no_history = EmployeePosition.find(:all, 
                                                     :select =>'DISTINCT position_number_id',
    :conditions =>['position_number_id IN (?) AND position_number_id NOT IN (?) and start_date <= LAST_DAY(?)',
    @deductable_position_numbers,@deductable_historic_position_numbers, @criteria_date])
    
    #Select all history rows that have current activity that fall outside the allowable time limit for vacancy.  This array 
    # only pulls in the previous months activity based on the run date.  The last day of the previous month is used as date criteria
    # to determine what rows to pull from the tables.
    
    @deductable_current_position_numbers.each do |dcpn|
      @history_with_current += EmployeePositionHist.find(:all, 
                                                         :select =>['a.position_number_id, a.employee_id as filling_employee, a.start_date, b.end_date,
                                           b.employee_id as leaving_employee, DATEDIFF(a.start_date, b.end_date) as days_outstanding'],
      :from => ['employee_positions a, employee_position_hists b'],
      :conditions =>['a.position_number_id = b.position_number_id and a.position_number_id = ? and 
                                              a.start_date <= LAST_DAY(?) and DATEDIFF(a.start_date, b.end_date) >= ? AND 
                                              b.end_date = (SELECT MAX(end_date) FROM employee_position_hists where position_number_id = ?)',
      dcpn.id, @criteria_date, dcpn.position_number.position.position_type.deduction_days, dcpn.id])
    end
    
    @not_assigned_report = []
    @newly_assigned_with_deductions_report = []
    
    
    
    @not_assigned.each do |na|
      @not_assigned_report += PositionNumber.find(:all,
                                                  :select=>['id, position_id, position_num, position_type, waiver_approval_date, created_on,
                                       DATEDIFF(LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH)), created_on) as days_outstanding'],
      :conditions=>['id = ? AND created_on <= LAST_DAY(?) and 
                                       DATEDIFF(LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH)), created_on) > (?)',
      na.id, @criteria_date, na.position.position_type.deduction_days])
    end
    
    @history = []
    @sort_report = []    
    
    @history_without_current.each do |hwc|
      @history += EmployeePositionHist.find(:all, 
                                            :select => ['position_number_id, NULL as filling_employee, NULL as start_date, end_date, 
                                                        employee_id as leaving_employee, DATEDIFF(LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH)), end_date) as days_outstanding'], 
      :conditions => ['position_number_id = ? and DATEDIFF(LAST_DAY(?), end_date) >= ? and 
                                            end_date = (SELECT MAX(end_date) FROM employee_position_hists where 
                                            position_number_id = ?)',hwc.position_number_id, @criteria_date, hwc.position_number.position.position_type.deduction_days, hwc.position_number_id])
    end
    
    
    
    @report = @history_with_current + @history
    
    
    @newly_assigned_with_deductions.each do |nawd|
      @sort_report += [{:position_type=> nawd.position_number.position.position_type.position_type, 
        :position_number => nawd.position_num,
        :position_title => nawd.position_number.position.title,
        :employee_vacate => "",
        :vacate_date => "",
        :hire_date => nawd.start_date,
        :employee_hire => nawd.employee_id,
        :salary => nawd.position_number.position.salary,
        :special_position_type => nawd.position_number.position_type,
        :date_waiver_approval => nawd.position_number.waiver_approval_date,
        :validation_days => nawd.start_date.to_date - nawd.created_on.to_date
      }]
    end
    
    @not_assigned_report.each do |nar|
      @sort_report += [{:position_type=> nar.position.position_type.position_type, 
        :position_number => nar.position_num,
        :position_title => nar.position.title,
        :employee_vacate => "",
        :vacate_date => "",
        :hire_date => "",
        :employee_hire => "",
        :salary => nar.position.salary,
        :special_position_type => nar.position_type,
        :date_waiver_approval => nar.waiver_approval_date,
        :validation_days => nar.days_outstanding
      }]
    end
    
    @report.each do |r|
      @sort_report += [{:position_type=> r.position_number.position.position_type.position_type, 
        :position_number => r.position_number.position_num,
        :position_title => r.position_number.position.title,
        :employee_vacate => r.leaving_employee,
        :vacate_date => r.end_date,
        :hire_date => r.start_date,
        :employee_hire => r.filling_employee,
        :salary => r.position_number.position.salary,
        :special_position_type => r.position_number.position_type,
        :date_waiver_approval => r.position_number.waiver_approval_date,
        :validation_days => r.days_outstanding
      }]
    end
    
    session[:report] = @sort_report = @sort_report.sort_by{|sr| sr[:position_type]}
  end
  s
  def export_excel    
    @now = Time.now
    @criteria_date = @now.last_month
    
    @report = session[:report]
    response.headers['CONTENT-TYPE'] = 'application/vnd.ms-excel'
    response.headers['CONTENT-DISPOSITION'] = 'attachment; filename="Incident Report -' + Time.now.to_s + '.xls"'
    render :type => 'application/vnd.ms-excel', :layout => false
  end
  
end
