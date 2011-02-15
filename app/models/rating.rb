class Rating
  # !! caution !!
  # http://groups.google.com/group/mongoid/browse_thread/thread/acfb4744f6f4e767
  include Mongoid::Document
  embedded_in :session, :inverse_of => :ratings
  referenced_in :user
  
  field :stars, :type => Integer, :default => 0
  validates_inclusion_of :stars, :in => 1..5
  
  attr_accessible :stars
end