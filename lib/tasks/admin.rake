namespace :admin do
  desc "generate check list"
  task :spreadsheet do
    require 'script/spreadsheet'
  end
end