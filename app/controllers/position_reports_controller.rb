class PositionReportsController < ApplicationController
  layout 'administration'    
  
  def index
    @now = Time.now
    @criteria_date = @now.last_month
        
    if request.post?
      unless params[:id] == ""
        session[:report_selection] = params[:id][:selection]
        
        case session[:report_selection]
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
    
    
    @not_assigned_position_numbers = []
    @current_assigned_no_history = []
    @current_assigned_with_history = []
    @history_with_no_current = []
    @report = []
    
    @deductable_position_numbers.each do |dpn|     
      @not_assigned_position_numbers += PositionNumber.find(:all, :conditions =>['id = ? and id not in(select position_number_id from employee_positions where start_date <= LAST_DAY(?))
                                                            and id not in (select position_number_id from employee_position_hists where start_date <= LAST_DAY(?))
                                                            and created_on <= LAST_DAY(?) and datediff(LAST_DAY(?),created_on) > ?', dpn.id,
                                                            @criteria_date, @criteria_date,@criteria_date, @criteria_date,dpn.position.position_type.deduction_days])    
      
      @current_assigned_no_history += EmployeePosition.find(:all,:from =>'employee_positions ep, position_numbers pn',:conditions =>['ep.position_number_id = ? and ep.position_number_id = pn.id
                                                             and ep.start_date between ? AND ? and ep.position_number_id not in (select position_number_id from employee_position_hists)
                                                             and datediff(ep.start_date ,pn.created_on) > ?', dpn.id, @criteria_date.at_beginning_of_month, 
                                                             @criteria_date.at_end_of_month, dpn.position.position_type.deduction_days])
                                                            
      @current_assigned_with_history += EmployeePosition.find(:all, :select =>'ep.position_number_id, ep.employee_id as filling_employee, ep.start_date, eph.end_date,
                                                               eph.employee_id as leaving_employee',:from =>'employee_positions ep, employee_position_hists eph',
                                                              :conditions => ['ep.position_number_id = ? and ep.start_date between ? AND ? and ep.position_number_id = eph.position_number_id
                                                               and eph.end_date = (select max(end_date) from employee_position_hists where position_number_id = ?)
                                                               and datediff(ep.start_date,(select max(end_date) from employee_position_hists where position_number_id = ?))',
                                                              dpn.id, @criteria_date.at_beginning_of_month, @criteria_date.at_end_of_month, dpn.id,dpn.id])
            
      @history_with_no_current += EmployeePositionHist.find(:all, :conditions =>['position_number_id = ? and position_number_id not in 
                                                            (select position_number_id from employee_positions where start_date <= ?)
                                                            and datediff(?, (select max(end_date) from employee_position_hists
                                                            where position_number_id = ?)) > ?', dpn.id, @criteria_date.at_end_of_month,
                                                            @criteria_date.at_end_of_month, dpn.id, dpn.position.position_type.deduction_days])
    end
   
    
    @not_assigned_position_numbers.each do |napn|    
      @report += [{
        :position_type=> napn.position.position_type.position_type, 
        :position_number => napn.position_num,
        :position_title => napn.position.title,
        :employee_vacate => "",
        :vacate_date => "",
        :hire_date => "",
        :employee_hire => "",
        :salary => napn.position.salary,
        :special_position_type => napn.position_type,
        :date_waiver_approval => napn.waiver_approval_date,
        :validation_days => @criteria_date.at_end_of_month.to_date - napn.created_on.to_date - Time.days_in_month(@criteria_date.month, @criteria_date.year)
      }]
    end

    @current_assigned_no_history.each do |canh|
      @report += [{
        :position_type=> canh.position_number.position.position_type.position_type, 
        :position_number => canh.position_number.position_num,
        :position_title => canh.position_number.position.title,
        :employee_vacate => "",
        :vacate_date => "",
        :hire_date => canh.start_date,
        :employee_hire => canh.employee.first_name + " " + canh.employee.last_name,
        :salary => canh.position_number.position.salary,
        :special_position_type => canh.position_number.position_type,
        :date_waiver_approval => canh.position_number.waiver_approval_date,
        :validation_days => @criteria_date.at_end_of_month.to_date - canh.start_date.to_date - Time.days_in_month(@criteria_date.month, @criteria_date.year)
       }]
    end
    
    @current_assigned_with_history.each do |cawh|
      @report += [{
        :position_type=> cawh.position_number.position.position_type.position_type, 
        :position_number => cawh.position_number.position_num,
        :position_title => cawh.position_number.position.title,
        :employee_vacate => cawh.leaving_employee,
        :vacate_date => cawh.end_date,
        :hire_date => cawh.start_date,
        :employee_hire => cawh.filling_employee,
        :salary => cawh.position_number.position.salary,
        :special_position_type => cawh.position_number.position_type,
        :date_waiver_approval => cawh.position_number.waiver_approval_date,
        :validation_days => cawh.start_date.to_date - cawh.end_date.to_date - Time.days_in_month(@criteria_date.month, @criteria_date.year)
       }]
    end
    
    @history_with_no_current.each do |hwnc|
      @report += [{
        :position_type=> hwnc.position_number.position.position_type.position_type, 
        :position_number => hwnc.position_number.position_num,
        :position_title => hwnc.position_number.position.title,
        :employee_vacate => hwnc.employee_id,
        :vacate_date => hwnc.end_date,
        :hire_date => "",
        :employee_hire => "",
        :salary => hwnc.position_number.position.salary,
        :special_position_type => hwnc.position_number.position_type,
        :date_waiver_approval => hwnc.position_number.waiver_approval_date,
        :validation_days => @criteria_date.at_end_of_month.to_date - hwnc.end_date - Time.days_in_month(@criteria_date.month, @criteria_date.year)
        }]
    end
    
    session[:report] = @sort_report = @report.sort_by{|r| r[:position_type]}
    
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
