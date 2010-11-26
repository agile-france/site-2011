Then /^(?:|I )should see (?:a|an) "([^"]*)" (\w+)/ do |text, field|
  page.send("find_#{field}".to_sym, text)
end