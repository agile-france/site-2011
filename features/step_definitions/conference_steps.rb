# ouch, failed to use common steps to build a 2 level nested object
Given /^the latest conference has the following offers for product "([^"]*)":$/ do |ref, table|
  conference = Conference.last
  conference.owner = User.new(:email => 'org@xp.org', :password => 'git rocks').tap(&:save!)
  conference.save!
  
  p = conference.products.create(:ref => ref)
  table.hashes.each do |hash|
    conference.emit!(hash['ref'], hash['quantity'], p, hash['price'])
  end
  conference
end