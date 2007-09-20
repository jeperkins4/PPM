class PositionReportsController < ApplicationController
  layout 'administration'    
  
  def index  
    @now = Time.now
    @criteria_date = @now.last_month
    
    @deductable_position_type = PositionType.find(:all, :conditions => ['deductable = ?', 1])
    @deductable_positions = Position.find(:all, :conditions => ['position_type_id IN (?) and facility_id = ?', @deductable_position_type, session[:facility].id])
    
    if @deductable_positions != nil
      @deductable_position_numbers = PositionNumber.find(:all, :conditions => ['position_id IN (?) AND position_type = ? and waiver_approval_date is null', @deductable_positions, "none"])        
    end    
    
    if @deductable_position_numbers != nil
      @deductable_employee_positions = EmployeePosition.find(:all, :conditions =>['position_number_id IN (?)',@deductable_position_numbers])
    end     
    
    @deductable_current_position_numbers = EmployeePosition.find(:all, :select =>'position_number_id as id, position_number_id',:conditions =>['position_number_id IN (?)',@deductable_position_numbers])
    @deductable_historic_position_numbers = EmployeePositionHist.find(:all, :select =>'position_number_id as id',:conditions =>['position_number_id IN (?)',@deductable_position_numbers])
    
    if @deductable_current_position_numbers.empty?
      @deductable_current_position_numbers = ""
    end
    
    if @deductable_historic_position_numbers.empty?
      @deductable_historic_position_numbers = ""
    end
    
    @history_with_current = []
    
    # @history_with_current = EmployeePositionHist.find(:all, :select => 'DISTINCT position_number_id',:conditions =>['position_number_id IN (?)',@deductable_current_position_numbers])
    @history_without_current  = EmployeePositionHist.find(:all, 
                                                          :select => 'DISTINCT position_number_id',
    :conditions =>['position_number_id IN (?) AND position_number_id NOT IN (?)',@deductable_position_numbers, @deductable_current_position_numbers ])
    
    @current_with_no_history = EmployeePosition.find(:all, 
                                                     :select =>'DISTINCT position_number_id',
    :conditions =>['position_number_id IN (?) AND position_number_id NOT IN (?)',@deductable_position_numbers,@deductable_historic_position_numbers])
    
    #Select all history rows that have current activity that fall outside the allowable time limit for vacancy.  This array 
    # only pulls in the previous months activity based on the run date.  The last day of the previous month is used as date criteria
    # to determine what rows to pull from the tables.
    
    @deductable_current_position_numbers.each do |dcpn|
      @history_with_current += EmployeePositionHist.find(:all, 
                                                         :select =>['a.position_number_id, a.employee_id as filling_employee, a.start_date, b.end_date,
                                                          b.employee_id as leaving_employee, DATEDIFF(a.start_date, b.end_date) as days_outstanding'],
      :from => ['employee_positions a, employee_position_hists b'],
      :conditions =>['a.position_number_id = b.position_number_id and a.position_number_id = ? and a.start_date < LAST_DAY(?) and DATEDIFF(a.start_date, b.end_date) >= ? AND 
                                                     b.end_date = (SELECT MAX(end_date) FROM employee_position_hists where position_number_id = ?)',
      dcpn.id, @criteria_date, dcpn.position_number.position.position_type.deduction_days, dcpn.id])
    end
    
    
    @history = []
    @sort_report = []    
    
    @history_without_current.each do |hwc|
      @history += EmployeePositionHist.find(:all, 
                                            :select => ['position_number_id, NULL as filling_employee, NULL as start_date, end_date, employee_id as leaving_employee, DATEDIFF(CURDATE(), end_date) as days_outstanding'], 
      :conditions => ['position_number_id = ? and DATEDIFF(LAST_DAY(?), end_date) >= ? and 
      end_date = (SELECT MAX(end_date) FROM employee_position_hists where 
      position_number_id = ?)',hwc.position_number_id, @criteria_date, hwc.position_number.position.position_type.deduction_days, hwc.position_number_id])
    end
    
    #   @current_with_no_history.each do |hwc|
    #     @current2 += EmployeePosition.find(:all, :select => ['position_number_id, employee_id as filling_employee, start_date, end_date, NULL as leaving_employee'], :conditions => ['position_number_id = ?',hwc.position_number_id])
    #   end        
    
    @report = @history_with_current + @history
    
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
  
  def position_move
    
    @now = Time.now
    @criteria_date = @now.last_month
    
    @facility_employees = Employee.find(:all, :conditions=>['facility_id = ?', session[:facility].id])
    @facility_positions = Position.find(:all, :conditions=>['facility_id = ?', session[:facility].id])
    
    @possible_lateral_employees = EmployeePosition.find(:all,:select=>['a.employee_id'], :from=>['employee_positions a, employee_position_hists b'],
    :conditions =>['a.employee_id = b.employee_id and a.employee_id IN (?)', @facility_employees])
    
    
    @possible_lateral_employees.each do |ple|
      @new_position_number = EmployeePosition.find(:all, :conditions=>['employee_id = ?',ple.employee_id])
      @old_position_number = EmployeePositionHist.find(:all, :select=>['position_number_id'],
      :conditions=>['employee_id = ? AND end_date = (SELECT MAX(end_date) FROM employee_position_hists where employee_id = ?)',ple.employee_id, ple.employee_id])
      
      if @new_position_number.first.position_number.position_id == @old_position_number.first.position_number.position_id
        bang!
      end
      
    end
    #    , @criteria_date.at_end_of_month, @criteria_date.at_beginning_of_month])
    
  end
  
  def export_excel    
    @now = Time.now
    @criteria_date = @now.last_month
    
    @report = session[:report]
    response.headers['CONTENT-TYPE'] = 'application/vnd.ms-excel'
    response.headers['CONTENT-DISPOSITION'] = 'attachment; filename="Incident Report -' + Time.now.to_s + '.xls"'
    render :type => 'application/vnd.ms-excel', :layout => false
  end
  
end
