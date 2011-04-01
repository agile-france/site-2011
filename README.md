Install
=======

rvm 1.9.2
---------

* install rvm

* follow pretty straight [rvm documentation](http://rvm.beginrescueend.com/rvm/install/)

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

mongo shell
-----------

resources are on mongodb site

* [shell?](http://www.mongodb.org/display/DOCS/dbshell+Reference)
* [query?](http://www.mongodb.org/display/DOCS/Advanced+Queries)
* [upsert?](http://www.mongodb.org/display/DOCS/Updating)

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

rails console
-------------

it is there, for sure!

resource

* [mongoid documentation](http://mongoid.org/docs/querying/)

Revoke admin role to randy

    ruby-1.9.2-p0 > randy = User.where(:email => /^randy/).first
     => #<User _id: 4cb4e0cc1c94a27e7a000005, email: "randy@couture.com", encrypted_password: "$2a$10$OVi7LsFCgOIf8QZ/9YSWRuNFaGiPbfEI4PEvTxf9eiH7f1sD5aM7.", password_salt: "$2a$10$OVi7LsFCgOIf8QZ/9YSWRu", remember_token: nil, remember_created_at: nil, reset_password_token: nil, sign_in_count: 4, current_sign_in_at: 2010-11-24 22:22:22 UTC, last_sign_in_at: 2010-10-18 20:52:29 UTC, current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", first_name: "", last_name: "", bio: "yessssssssss", avatar: nil, admin: true> 
    ruby-1.9.2-p0 > randy.tap {|r|r.admin=false}.save!
     => true 
    ruby-1.9.2-p0 > randy.admin?
     => false

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

Javascripts
-----------

    rake jasmine
    
then goto http://localhost:8888 ... a graphical interface for test is quite annoying ...

And at this time, jasmine-1.0.1.1 webrick server resists to STOP, HUP... but not KILL :)


Integration kungfu
------------------

see

* http://github.com/aslakhellesoy/cucumber
* http://github.com/jnicklas/capybara

**cucumber has dedicated environment**

### optional spork
There is no automation for command line

Have spork ran for cucumber on its own port

    ~/src/ruby/conference-on-rails (vote)$ spork cucumber --port 12345
    
Then, can use following options to have cuke connect to it

    ./script/cucumber --drb --port 12345 features/session_rate.feature

**Gotcha**
    
    **@javascript tests using default js driver (selenium) are failing when spork is up**

### run them!

for one shot

    ./script/cucumber feature/this-one-is-red.feature
or

    ./script/cucumber --tags @this_one_is_red

see [cucumber and tags](http://github.com/aslakhellesoy/cucumber/wiki/tags), and [capybara tags](http://github.com/jnicklas/capybara)

		
### dunno why it fails :(
Add a handy step before offending step

    Then show me the page

then you go and see

### Gotchas

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
    
look out for seeds under #{Rails.root}/db/seeds/development (there is an admin there)

then

    rails s