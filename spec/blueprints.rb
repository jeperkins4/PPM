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
  address1         {Sham.address}
  state            { Sham.state}
  warden           { Sham.name}
  contract_monitor { Sham.name}
  zip 
  phone 
  city
end
Facility.blueprint(:with_position_number) do
  
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


