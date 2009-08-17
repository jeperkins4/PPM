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
  salary   { Faker.numerify '######.##'}
  create_date {(rand(0.99)+0.9).years.ago}
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
  mins { Faker.numerify('#######')}
  incident_date {(rand(1.5)+1).year.ago}
  reported_date {(rand(0.99)+0.9).years.ago}
  facility_investigation_complete_date {(rand(0.89)+0.80).years.ago}
end

IncidentClass.blueprint do
  incident_class { Faker::Lorem.words(1)}
  description    {Faker::Lorem.paragraph}
end

ActionType.blueprint do
  action { ['Downgraded','Referred to Management','Staff Termination','Staff Resigned','Staff Suspension','Inmate Transferred','Documented in Personnel Record','Inmate Arrested','Disciplinary Report Issued to Inmate',]}
  description
end

EmployeePosition.blueprint do
  position_number { PositionNumber.make}
  employee        { Employee.make}
  start_date      { (2..8).to_a.rand.years.ago }
end

Employee.blueprint do
  first_name
  last_name
  tea_status { %w{certified na facility academy pending registered}.rand }
end

Position.blueprint do
  title          { %w{WARDEN MANAGER DENTIST}.rand }
  salary         { Faker.numerify((5..8).to_a.rand.times.map {|a| '#'}.join('')+'.##')}
  description    
  position_type       { PositionType.make }
end

PositionNumber.blueprint do
  position_num { Faker.numerify('#######')}
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

PositionType.blueprint(:with_facility) do
  position_type  { ['Security', 'Non-Security'].rand }
  description    
  deductable     { (0..1).to_a.rand }
  deduction_days { (10..120).to_a.rand }
  facility       { Facility.make }
end

AccessLevel.blueprint do
  id { 2 }
  access_level { Sham.word }
end

AccessLevel.blueprint(:administrator) do
  id { 1 }
  access_level { 'Administrator' }
  description  {'Replace Text'}
end

UserType.blueprint do
  id { 2 }
  user_type {'some type'}
  access_level { AccessLevel.make }
end
UserType.blueprint(:administrator) do
  user_type    { 'Administrator'}
  description  { 'Full rights'}
  access_level { AccessLevel.make(:administrator)}
end

User.blueprint do
  name { Sham.user_name}
  password  { 'faker' }
  password_confirmation { 'faker' }
end

User.blueprint(:administrator) do
  name { Sham.user_name}
  password  { 'faker' }
  password_confirmation { password }
  user_type { UserType.make(:administrator) }
end


