#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
agile_france_2011 = {:name => 'Agile France', :edition => 2011}
if Conference.where(agile_france_2011).empty?
  c = Conference.create(agile_france_2011)
  puts "created #{c}"
end

# load additional files located in ./seeds/#{env}
pattern = Rails.root.join("db/seeds/#{Rails.env}/**.rb")
Dir.glob(pattern).each {|file|
  puts "load #{file}"
  load file
}
