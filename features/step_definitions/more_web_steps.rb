Then /^(?:|I )should see (?:a|an) "([^"]*)" (\w+)/ do |text, field|
  page.send("find_#{field}".to_sym, text)
end

Given /^I validate "([^"]*)" form$/ do |form|
  within(form) do
    button = XPath.descendant(:input)[XPath.attr(:type) == 'submit']
    find(:xpath, button, message: 'ouch!!').click
  end
end