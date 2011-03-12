# More info at http://github.com/guard/guard#readme

guard 'rspec', :version => 2, :cli => '--drb' do
  watch(%r{^spec/(.*)_spec.rb})
  watch(%r{^lib/(.*)\.rb})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')                       { "spec" }
  
  # Rails
  watch(%r{^app/(.*)\.rb})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch('config/routes.rb')                          { "spec/routing" }
  watch('app/controllers/application_controller.rb') { "spec/controllers" }
  watch('spec/fabricators')                          { "spec/models" }
end

guard 'coffeescript', :output => 'public/javascripts' do
  watch(%r{app/coffeescripts/.+\.coffee})
end
