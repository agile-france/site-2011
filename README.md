Install
=======

rvm 1.9.2
---------

* install rvm

* follow pretty straight [rvm documentation] (http://rvm.beginrescueend.com/rvm/install/)

* read notes

        rvm notes
    
  look at whether additional libraries are required

* install 1.9.2

        rvm install 1.9.2
        rvm use 1.9.2 --default

get source
----------

		gem install bundler
		bundle install


Data
====

use mongo shell

resources are on mongodb site

* [shell?] (http://www.mongodb.org/display/DOCS/dbshell+Reference)
* [query?] (http://www.mongodb.org/display/DOCS/Advanced+Queries)
* [upsert?] (http://www.mongodb.org/display/DOCS/Updating)

recipe : admin role 
-------------------

launch mongo shell, with correct database

    ~/src/ruby/conference-on-rails (search)$ mongo
    MongoDB shell version: 1.6.4
    connecting to: test
    > use conference_on_rails_development
    switched to db conference_on_rails_development

find users whose email begins with randy, returning [admin, email] fields

    > db.users.find({email : /^randy/}, {email : 1, admin : 1});
    { "_id" : ObjectId("4cb4e0cc1c94a27e7a000005"), "admin" : false, "email" : "randy@couture.com" }

turn such users to admin

    > db.users.update({email : /^randy/}, {$set : {"admin" : true}});

Tests
=====

Unit 
----
see http://github.com/rspec/rspec

### flow them!
		guard
		
or for one shot,

		rspec spec/
		
### dunno why it fails :(
add a debugger statement, and type then

    rspec -d spec/failing_spec.rb

!!! caution : I do not recommand debugging with a running spork drb server (personal taste)!!!

this practice is not related to rails (though pretty described in http://guides.rubyonrails.org/debugging_rails_applications.html)

Integration kungfu
------------------

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

Metrics
=======
coverage, using simplecov
-------------------------

kill any spork drb server before, otherwise, coverage is not generated (at_exit spork)

    COVERAGE=true rspec spec

no support for cucumber provided coverage, at this time

where the bloody site ?
=======================

seed database at least once

    rake db:seed
    
then

    rails s