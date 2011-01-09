class Authentication
  include Mongoid::Document
  field :provider
  field :uid
  referenced_in :user
end