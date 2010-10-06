require 'wrong'
RSpec::Rails::TestUnitAssertionAdapter::AssertionDelegate.send(:include, Wrong::Assert)