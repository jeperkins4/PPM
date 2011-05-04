Then /^(?:|I )should see the fieldset "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_css("fieldset", :text => /#{text}/, :visible => true)
  else
    assert page.has_css("fieldset", :text => /#{text}/, :visible => true)
  end
end

Then /^(?:|I )should not see the fieldset "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_css("fieldset", :text => /#{text}/, :visible => true)
  else
    assert page.has_no_css("fieldset", :text => /#{text}/, :visible => true)
  end
end

Then /^(?:|I )should see the field "([^"]*)"$/ do |field|
  if page.respond_to? :should
    page.should have_field(field, :visible => true)
  else
    assert page.has_field(field, :visible => true)
  end
end

Then /^(?:|I )should not see the field "([^"]*)"$/ do |field|
  if page.respond_to? :should
    page.should have_no_field(field, :visible => true)
  else
    assert page.has_no_field(field, :visible => true)
  end
end

Then /^(?:|I )should see the label "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_css("label", :text => text, :visible => true)
  else
    assert page.has_css('label', :text => text, :visible => true)
  end
end

Then /^(?:|I )should not see the label "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_css("label", :text => text, :visible => true)
  else
    assert page.has_no_css('label', :text => text, :visible => true)
  end
end

Then /^(?:|I )should see the link "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_link(text, :visible => true)
  else
    assert page.has_link(text, :visible => true)
  end
end

Then /^(?:|I )should not see the link "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_link(text, :visible => true)
  else
    assert page.has_no_link(text, :visible => true)
  end
end

Then /^"([^"]*)" should be an option in "([^"]*)"$/ do |option_value, select_box|
  if page.respond_to? :should
    page.find_field(select_box).should have_css('option', :text => option_value)
  else
    assert page.find_field(select_box).has_css('option', :text => option_value)
  end
end

Given /^(?:I )change "([^"]*)" by selecting "([^"]*)"$/ do |field, value|
  page.select(value, :from => field)
  select = find(:xpath, XPath::HTML.select(field), :message => "The 'select' field #{field} does not exist")
  page.evaluate_script("document.getElementById('#{select['id']}')")
end
