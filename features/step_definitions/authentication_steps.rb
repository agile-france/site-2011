Given /^I am not authenticated$/ do
  visit('/users/sign_out') # ensure that at least
end

Given /^I have one\s+user "([^"]*)" with password "([^"]*)"$/ do |email, password|
  User.new(:email => email,
           :password => password,
           :password_confirmation => password).save!
end