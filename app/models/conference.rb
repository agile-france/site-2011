class Conference
  include Mongoid::Document
  include Mongoid::Timestamps
  has_many :sessions
  has_many :products
  has_many :registrations
  has_many :invoices

  field :name
  field :edition
  field :registration_engines, type: Array
  attr_accessible :name, :edition, :registration_engines
  key :name, :edition

  # Public : new empty invoice for user
  def new_invoice_for(user)
    invoices.build(user: user)
  end
end
