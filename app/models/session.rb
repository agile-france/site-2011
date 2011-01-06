class Session
  include Mongoid::Document
  include Mongoid::Taggable
  include Mongoid::Timestamps
  
  referenced_in :conference
  referenced_in :user
  
  field :title
  field :description
  field :format
  field :capacity, :type => Integer
  field :level
  field :age
  
  attr_accessible :title, :description, :format, :capacity, :level, :age
  attr_accessible :tags
  
  validates :capacity, :numericality => true, :allow_nil => true
end
