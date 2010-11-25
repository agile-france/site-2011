class Session
  include Mongoid::Document
  include Mongoid::Taggable
  
  referenced_in :conference, :inverse_of => :sessions
  referenced_in :user
  
  field :title
  field :description
end
