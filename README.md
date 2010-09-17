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
add a debugger statement, then go to irb, quit when more knowledge is gain (^D will go to rdb)

this practice is not related to rails (though pretty described in http://guides.rubyonrails.org/debugging_rails_applications.html)

## integration kungfu

see

* http://github.com/aslakhellesoy/cucumber
* http://github.com/jnicklas/capybara

### run them!
for unit test and cukes, do

		AUTOFEATURE=true bundle exec autotest

or for one shot

		rake cucumber
or
    cucumber
		
### dunno why it fails :(
for jqueryless behavior, add a handy step before offending step

	Then show me the page

then you go and see

# metrics
## rcov
slow