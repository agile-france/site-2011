class Conference
  include Mongoid::Document  
  references_many :sessions
  
  field :name
  field :edition
end
