require 'wrong'
require 'rspec/rails/adapters'
RSpec::Rails::TestUnitAssertionAdapter::AssertionDelegate.send(:include, Wrong)
require 'wrong/adapters/rspec'