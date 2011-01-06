class Company
  include Mongoid::Document
  references_many :users
  field :name
  field :naf
  
  attr_accessible :name, :naf
end