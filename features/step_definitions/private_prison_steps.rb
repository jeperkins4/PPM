# I've spent the majority of my time for the current task trying to
# Upgrade to the latest version of Rails. 
# implementing steps and scenarios will have to wait until the next
# task.

Given /^I am a logged in facility manager$/ do
  u = User.make(:administrator, {:password => 'aaaa', 
                :password_confirmation => 'aaaa',
                :facility => Facility.make})
  visit path_to 'the homepage'
  fill_in :name, :with => u.name
  fill_in :password, :with => 'aaaa'
  click_button 'Login'
end

Given /^the facility has a position "([^\"]*)"$/ do |title|
  f = Facility.first
  Position.make(:title => title, :position_type => PositionType.make(:facility => f))
end

Given /^the position has a position_number "([^\"]*)"$/ do |position_number|
  p = Position.first
  p.position_numbers << PositionNumber.make(:position_num => position_number)
end

Given /^the facility has an employee "([^\"]*)"$/ do |first_name_last_name|
  first_name, last_name = first_name_last_name.split(' ')
  Employee.make(:first_name => first_name, :last_name => last_name, :facility => Facility.make)
end

Given /^the the employee is assigned to the position_number$/ do
  EmployeePosition.create(:employee => Employee.first, :position_number => PositionNumber.first)
end

Given /^I am set up to use position_numbers for "([^\"]*)"$/ do |facility|
    Given "I am a logged in facility manager for the facility \"#{facility}\""
    Given "the facility has a position \"Clerk\""
    Given "the position has a position_number \"12345\""
    Given "the facility has an employee \"Bob Keyt\""

end

Given /^the facility has an inactive position_number "([^\"]*)"$/ do |position_number|
  position = Facility.first.position_types[0].positions[0]
  position_number = PositionNumber.make(:position_num => position_number, 
                                        :position => position)
  position_number.update_attribute(:active_flag, false)
end

When /^I follow edit "([^\"]*)"$/ do |arg1|
  pending
end

When /^I click "([^\"]*)"$/ do |arg1|
  pending
end

When /^I submit the form$/ do
  pending
end
