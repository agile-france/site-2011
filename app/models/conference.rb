class Conference
  include Mongoid::Document
  include Mongoid::Timestamps
  references_many :sessions
  
  field :name
  field :edition
  attr_accessible :name, :edition
  key :name, :edition
end
