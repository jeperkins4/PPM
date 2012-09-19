<<<<<<< HEAD
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if true
  puts "Processing Access Levels"
  AccessLevel.destroy_all
  Legacy::AccessLevel.all.each do |c|
    AccessLevel.create!(:id => c.id, :name => c.access_level, :description => c.description)
  end

  puts "Processing User Types"
  UserType.destroy_all
  Legacy::UserType.all.each do |c|
    UserType.create!(:id => c.id, :name => c.user_type, :description => c.description, :access_level_id => c.access_level_id)
  end

  puts "Processing User"
  User.destroy_all
  puts "User count is #{User.count}"
  User.create!(:username => 'jeperkins4', :email => 'jeperkins4@gmail.com', :firstname => 'John', :lastname => 'Perkins', :user_type_id => 4, :password => 'asdfasdf', :password_confirmation => 'asdfasdf')
  Legacy::User.all.each do |c|
#    User.create!(:id => c.id, :username => c.name, :email => c.email, :firstname => c.firstname, :lastname => c.lastname, :user_type_id => c.user_type_id, :inactive_on => c.inactive_on, :inactive_comment => c.inactive_comment )
  end

  puts "Processing Action Types"
  ActionType.destroy_all
  Legacy::ActionType.all.each do |c|
    ActionType.create!(:id => c.id, :name => c.action, :description => c.description)
  end

  if true
    puts "Processing Accountability Log Details"
    AccountabilityLogDetail.destroy_all
    Legacy::AccountabilityLogDetail.all.each do |c|
      AccountabilityLogDetail.create!(:id => c.id, :facility_id => c.facility_id, :context_id => c.context_id, :detail_response => c.detail_response, :log_year => c.log_year, :log_month => c.log_month, :logged_at => Date.new(c.log_year, c.log_month))
    end

    puts "Processing Accountability Log"
    AccountabilityLog.destroy_all
    Legacy::AccountabilityLog.all.each do |c|
      AccountabilityLog.create!(:id => c.id, :facility_id => c.facility_id, :context_id => c.context_id, :prompt_id => c.prompt_id, :response => c.response, :log_year => c.log_year, :log_month => c.log_month, :logged_at => Date.new(c.log_year, c.log_month))
    end
  end

  puts "Processing Context"
  Context.destroy_all
  Legacy::Context.all.each do |c|
    Context.create!(:id => c.id, :title => c.title, :description => c.description, :position => c.position)
  end

  puts "Processing Custody Types"
  CustodyType.destroy_all
  Legacy::CustodyType.all.each do |c|
    CustodyType.create!(:id => c.id, :name => c.custody_type, :description => c.description)
  end

  puts "Processing Employee Position Histories"
  EmployeePositionHistory.destroy_all
  Legacy::EmployeePositionHist.all.each do |c|
    EmployeePositionHistory.create!(:id => c.id, :position_number_id => c.position_number_id, :employee_id => c.employee_id, :start_date => c.start_date, :end_date => c.end_date, :salary => c.salary)
  end

  puts "Processing Employees" 
  Employee.destroy_all
  Legacy::Employee.all.each do |c|
    begin
      Employee.create!(:id => c.id, :facility_id => c.facility_id, :firstname => c.first_name, :lastname => c.last_name, :emplid => c.emplid, :active => c.active, :tea_status => c.tea_status)
    rescue => e
    end
  end

  puts "Processing Facility" 
  Facility.destroy_all
  Legacy::Facility.all.each do |c|
    Facility.create!(:id => c.id, :name => c.facility, :shortname => c.shortname, :address1 => c.address1, :address2 => c.address2, :city => c.city, :state => c.state, :zip => c.zip, :phone => c.phone, :warden => c.warden, :contract_monitor => c.contract_monitor, :pppams_started_on => c.pppams_started_on)
  end

  if false # This join does not exist
    puts "Processing Join Table between Custody Types and Facilities"
    Legacy::FacilityCustody.all.each do |c|
      facility = Facility.find(c.facility_id)
      facility.custody_types << CustodyType.find(c.custody_type_id)
      facility.save!
    end
  end
end

  puts "Processing Incident Types"
  IncidentType.destroy_all
  Legacy::IncidentType.all.each do |c|
    IncidentType.create!(:id => c.id, :name => c.incident_type, :description => c.description)
  end

if true
  puts "Processing Incidents" 
  Incident.destroy_all
  Legacy::Incident.all.each do |c|
    Incident.create!(:id => c.id, :facility_id => c.facility_id, :incident_on => c.incident_date, :reported_on => c.reported_date, :inspector_general_on => c.inspector_general, :description => c.description, :incident_type_id => c.incident_type_id, :contract_manager_notified_on => c.contract_manager_notified_date, :bureau_notified_on => c.bureau_notified_date, :warden_notified_on => c.warden_notified_date, :facility_investigation_completed_on => c.facility_investigation_complete_date, :action_type_id => c.action_type_id, :incident_type_other => c.incident_type_other, :incident_class_id => c.incident_class_id, :investigator_id => c.investigator_id, :mins => c.mins, :action_type_other => c.action_type_other, :designee_name => c.designee_name, :contract_manager_notified => c.contract_manager_notified, :warden_notified => c.warden_notified, :bureau_notified => c.bureau_notified, :facility_investigation_complete => c.facility_investigation_complete, :investigation_closed => c.investigation_closed, :investigation_closed_on => c.investigation_closed_date, :entity_closing => c.entity_closing)
  end

  puts "Processing Investigator" 
  Investigator.destroy_all
  Legacy::Investigator.all.each do |c|
    Investigator.create!(:id => c.id, :facility_id => c.facility_id, :firstname => c.firstname, :lastname => c.lastname, :entity => c.entity, :phone => c.phone, :email => c.email)
  end

  puts "Processing Position Types"
  PositionType.destroy_all
  Legacy::PositionType.all.each do |c|
    PositionType.create!(:id => c.id, :name => c.position_type, :description => c.description, :deductable => c.deductable, :deduction_days => c.deduction_days, :facility_id => c.facility_id)
  end

  puts "Processing Position Numbers"
  PositionNumber.destroy_all
  Legacy::PositionNumber.all.each do |c|
    puts "Found #{c.position_type}"
    types = PositionType.where(:name => c.position_type)
    if types.empty?
      type_id = nil
    else
      type_id = types.first.id
    end
      
    PositionNumber.create!(:id => c.id, :position_id => c.position_id, :position_num => c.position_num, :position_type_id => type_id, :waiver_approval_date => c.waiver_approval_date, :active => c.active_flag, :inactive_on => c.inactive_on, :inactive_comment => c.inactive_comment)
  end

  puts "Processing Position"
  Position.destroy_all
  Legacy::Position.all.each do |c|
    Position.create!(:id => c.id, :title => c.title, :position_type_id => c.position_type_id, :description => c.description, :salary => c.salary)
  end
end

puts "Processing Prompts"
Prompt.destroy_all
Legacy::Prompt.all.each do |c|
  Prompt.create(:id => c.id, :question => c.question, :description => c.description, :context_id => c.context_id, :used_in_total => c.used_in_total, :active => c.active)
end
=======
require 'active_record/fixtures'
# All environments
all_seeds = Dir["db/seeds/*.csv"].map { |file| File.basename(file, '.csv').to_sym }
Fixtures.create_fixtures('db/seeds', all_seeds)

#The current environment
environment_specific_seeds = Dir["db/seeds/#{Rails.env}/*.csv"].map { |file| File.basename(file, '.csv').to_sym }
Fixtures.create_fixtures("db/seeds/#{Rails.env}", environment_specific_seeds)
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
