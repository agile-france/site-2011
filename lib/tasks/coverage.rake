task :coverage do
  require 'cover_me'
  task(:rspec).invoke
  task(:cucumber).invoke
end