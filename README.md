# install

## rvm 1.9.2

* install rvm
* follow pretty straight http://rvm.beginrescueend.com/rvm/install/
* look at library requirements if using venerable libraries

		rvm install 1.9.2
		rvm default 1.9.2

## get source
		gem install bundler
		bundle install

# tests?
## unit style 
see http://github.com/rspec/rspec

### flow them!
		bundle exec autotest
or for one shot,
		rspec spec/
		
### dunno why it fails :(
add a debugger statement, and type then

    rspec -d spec/failing_spec.rb

!!! caution : I do not recommand debugging with a running spork drb server (personal taste)!!!

this practice is not related to rails (though pretty described in http://guides.rubyonrails.org/debugging_rails_applications.html)

## integration kungfu

see

* http://github.com/aslakhellesoy/cucumber
* http://github.com/jnicklas/capybara

### run them!
for unit test and cukes, do

		AUTOFEATURE=true bundle exec autotest

or for one shot

    cucumber feature/this-one-is-red.feature
or

    cucumber --tags @this_one_is_red

see [cucumber and tags](http://github.com/aslakhellesoy/cucumber/wiki/tags), and [capybara tags](http://github.com/jnicklas/capybara)

		
### dunno why it fails :(
for jqueryless behavior, add a handy step before offending step

    Then show me the page

then you go and see

# metrics
## coverage, using simplecov
kill any spork drb server before, otherwise, coverage is not generated (at_exit spork)

    COVERAGE=true rspec spec

no support for cucumber provided coverage, at this time

# where the bloody site ?
at least once
    rake db:setup
    
then
    rails s
