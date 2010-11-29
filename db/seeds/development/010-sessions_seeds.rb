def describe(i)
  description = <<-EOF
  Amazing session
  ===============
  #{i}
  EOF
end

(1..50).each { |i|
  user = User.where(:email => Regexp.new("^speaker-#{i}")).first
  Session.new(:title => "session #{i}", :description => describe(i), :user => user).save
}