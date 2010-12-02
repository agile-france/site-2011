User.new(:email => "you@admin.com", :password => 'you rock!').tap{|s| s.admin=true}.save
