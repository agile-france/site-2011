Given /^I (?:am not authenticated|sign(?:ed|) out)$/ do
  visit('/users/sign_out') # ensure that at least
end

Given /^I have one\s+user "([^"]*)" with password "([^"]*)"$/ do |email, password|
  User.new(:email => email,
           :password => password,
           :password_confirmation => password).save!
end

Given /^I am a new, authenticated user$/ do
  email = 'testing@man.net'
  Given %{I sign in as "#{email}"}
end

Given /^I complete sign in form with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  Given %{I go to the user session page}
    And %{I fill in "user_email" with "#{email}"}
    And %{I fill in "user_password" with "#{password}"}
    And %{I press "user_submit"}  
end

Given /^I (?:signed|sign) in as "([^"]*)"$/ do |email|
  password = 'secretpass'
  Given %{I have one user "#{email}" with password "#{password}"} unless User.identified_by_email(email)
  Given %{I complete sign in form with email "#{email}" and password "#{password}"}
end
