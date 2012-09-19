require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.define do
  company { Faker::Company.name}
  company_short {company[0..10]}
  address { Faker::Address.street_address}
  city    { Faker::Address.city}
  state   { Faker::Address.us_state}
  zip     { Faker::Address.zip_code }
  phone   { Faker::PhoneNumber.phone_number}
  name    { Faker::Name.name}
  description { Faker::Lorem.paragraphs(3)}
  user_name { Faker::Internet.user_name}
  first_name {Faker::Name.first_name}
  last_name { Faker::Name.last_name}
  email   { Faker::Internet.email }
  word    { Faker::Lorem.words(1)}
  sentence { Faker::Lorem.sentence }
end

Context.blueprint do
  title {Faker::Lorem.words(3)}
end
AccountabilityLogs.blueprint do
  facility {Facility.make}
  log_year {Date.today.year}
  log_month {Date.today.month}
end

Prompt.blueprint do
  question {Faker::Lorem.sentence}
end

Facility.blueprint do
  facility         { Sham.company }
  address1         { Sham.address}
  state            { Sham.state}
  warden           { Sham.name}
  contract_monitor { Sham.name}
  zip 
  phone 
  city
end
PositionHist.blueprint do
  position { Position.make }
  salary   { Faker::Base.numerify '######.##'}
  create_date {(17..18).to_a.rand.months.ago}
end
IncidentType.blueprint do
  incident_type {['Aggravated Battery (Inmate vs. Inmate)','Assault or Battery on Inmate','Assault or Battery on Staff','Attempted Escape','Attempted Suicide','Battery on Law Enforcement Officer','Computer Security Incident','Drugs Found','Emergency Evacuation','Employee Death','Escape','Excessive Force','Fire','High Profile Incidents','Hostage Situation','Improper Conduct (Inmate)','Inmate Death','Inmate/Employee Work Stoppage','Major Disturbance','Natural or Environmental Disaster','Physical Abuse (Staff on Inmate)','Recovery of Contraband','Recovery of Weapon','Serious Accident','Serious Battery (life threatening)','Sexual Battery (inmate on inmate)','Sexual Battery (staff member)','Staff/Offender Relationship','Total Lockdown of Institution','Use of Force Reports','Use or Discovery of an Explosive','Use or Discovery of a Firearm','Weapon Found']}
  description {Faker::Lorem.paragraph}
end

Incident.blueprint do
  facility {Facility.make}
  incident_type {IncidentType.make}
  incident_class {IncidentClass.make}
  action_type {ActionType.make}
  mins { Faker::Base.numerify('#######')}
  incident_date {(12..16).to_a.rand.months.ago}
  reported_date {(10..11).to_a.rand.months.ago}
  facility_investigation_complete_date {(7..9).to_a.rand.months.ago}
end

IncidentClass.blueprint do
  incident_class { Faker::Lorem.words(1)}
  description    {Faker::Lorem.paragraphs(1) }
end

ActionType.blueprint do
  action { 'a'}#['Downgraded','Referred to Management','Staff Termination','Staff Resigned','Staff Suspension','Inmate Transferred','Documented in Personnel Record','Inmate Arrested','Disciplinary Report Issued to Inmate',]}
  description
end

EmployeePosition.blueprint do
  position_number { PositionNumber.make}
  employee        { Employee.make}
  start_date      { 3.years.ago }#(2..8).to_a.rand.years.ago }
end

Employee.blueprint do
  first_name
  last_name
  tea_status { 'certified'}# $%w{certified na facility academy pending registered}.rand }
end

Position.blueprint do
  title          { %w{WARDEN MANAGER DENTIST}.rand }
  salary         { Faker::Base.numerify((5..8).to_a.rand.times.map {|a| '#'}.join('')+'.##')}
  description    
  position_type       { PositionType.make }
end

PositionNumber.blueprint do
  position_num { Faker::Base.numerify('#######')}
  position { Position.make}
  position_type { %w{none iwtf contract}.rand}
end

PositionType.blueprint do
  position_type  { ['Security', 'Non-Security'].rand }
  description
  deductable     { (0..1).to_a.rand }
  deduction_days { (10..120).to_a.rand }
  facility       { Facility.make }
end

NonCompIssue.blueprint do
  facility          {Facility.make}
  discovery_date    {3.days.ago}
  details           {Faker::Lorem.paragraph}
  requirement       {"OMC Article 5."+(0..100).to_a.rand.to_s}
  notification_date {2.days.ago}
  cap_due_date      {1.days.ago}
  cap_review_date   {1.day.from_now}
end

PositionType.blueprint(:with_facility) do
  position_type  { 'aoeu' }#['Security', 'Non-Security'].rand }
  description    
  deductable     { (0..1).to_a.rand }
  deduction_days { (10..120).to_a.rand }
  facility       { Facility.make }
end


User.blueprint do
  name { 'aoeu'}
  email
  firstname {Sham.first_name}
  lastname  {Sham.last_name }
  password  { 'faker' }
  password_confirmation { 'faker' }
  user_type { UserType.contract_manager}
end

User.blueprint(:administrator) do
  name { 'aoeuao'}
  user_type { UserType.administrator }
  facility { Facility.make }
end

User.blueprint(:contract_manager) do
  name { 'aoeuao3'}
  user_type { UserType.contract_manager}
  facility { Facility.make }
end

PppamsCategoryGroup.blueprint do
  name { Faker::Lorem.words(3) }
end
Upload.blueprint do
  size { Faker::Base.numerify('######') }
  file_type { %w{application/pdf application/vnd.ms-excel image/pjpeg application/octet-stream application/msword text/html application/vnd.ms-powerpoint application/vnd.openxmlformats-officedocument.wordprocessingml.document image/tiff text/plain application/vnd.openxmlformats-officedocument.spreadsheetml.sheet}.rand}
  name { Faker::Lorem.words(3)}
end
PppamsCategoryBaseRef.blueprint do
  name {Sham.sentence }
  pppams_category_group {PppamsCategoryGroup.make}
end
PppamsIndicator.blueprint do
  pppams_indicator_base_ref {PppamsIndicatorBaseRef.make}
  frequency { 1 }
  facility {Facility.make}
  start_month { (1..12).to_a.rand }
  good_months {":#{start_month}:"}
end
PppamsIndicatorBaseRef.blueprint do
  question { Sham.sentence }
  pppams_category_base_ref {PppamsCategoryBaseRef.make}
end
PppamsReview.blueprint do
  score {6}
  observation_ref { 'some observation'}
  documentation_ref { 'some documentation'}
  interview_ref { 'some interview'}
  notes { 'some notes'}
end
