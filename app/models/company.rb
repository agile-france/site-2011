class Company
  include Mongoid::Document
  references_many :users
  field :name
  field :naf
  
  attr_accessible :name, :naf
  
  validates :name, :uniqueness => true

  class << self
    def identified_by_name(name)
      where(:name => name).first
    end
  end
end