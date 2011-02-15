Given /^"([^"]*)" propose following session:$/ do |email, table|
  table.hashes.each do |hash|
    User.identified_by_email(email).propose(::Session.new(hash), current_conference)
  end
end