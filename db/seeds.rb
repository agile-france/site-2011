#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# ugly seeding, no environment, monolithic
agile_france_2011 = {:name => 'agile-france', :edition => 2011}
if Conference.where(agile_france_2011).empty?
  c = Conference.create(agile_france_2011) 
  puts "created #{c}"
end