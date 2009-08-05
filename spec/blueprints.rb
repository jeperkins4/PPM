require 'machinist/active_record'
require 'sham'

Sham.define do
  full_company_name = Faker::Compary.name
  company { full_company_name}
  company_short {full_name[0..3]}
  address { Faker::Address.street_address}
  city    { Faker::Address.city}
  state   { Faker::Address.us_state}
  zip     { Faker::Address.zip_code }
  phone   { Faker::PhoneNumber.phone_number}
  name    { Faker::Name.name}
  pos_title %w{WARDEN MANAGER DENTIST}.rand
  paragraphs { Faker::Lorem.paragraphs(3)}
end

Facility.blueprint do
  facility         { Sham.company }
  short_name       { Sham.company_short }
  address1         {Sham.address}
  city             { Sham.city}
  state            { Sham.state}
  zip              { Sham.zip }
  phone            { Sham.phone}
  warden           { Sham.name}
  contract_monitor { Sham.name}
end

Position.blueprint do
  title          { Sham.pos_title}
  salary_decimal { Faker.numerify((5..8).to_a.rand.times.map {|a| '#'}.join('')+'.##')}
  description    { Sham.paragraphs }
end

PositionType.blueprint do
  position_type  { ['Security', 'Non-Security'].rand }
  description    { Sham.paragraphs }
  deductable     { (0..1).to_a.rand }
  deduction_days { (10..120).to_a.rand }
  
end