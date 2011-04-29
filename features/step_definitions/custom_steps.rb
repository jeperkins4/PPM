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
